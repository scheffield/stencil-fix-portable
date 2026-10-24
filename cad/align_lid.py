"""Correct/check the lid guide holes in the original STEP (CadQuery 2.8.0)."""

import argparse
from itertools import product
from pathlib import Path
import re

import cadquery as cq


CORNERS = tuple(product((-1, 1), repeat=2))


def guide_centres(shape, radius):
    centres = set()
    for face in shape.Faces():
        if face.geomType() != 'CYLINDER':
            continue
        cylinder = face._geomAdaptor().Cylinder()
        if abs(cylinder.Radius() - radius) > 1e-6:
            continue
        x, y, _ = cylinder.Location().Coord()
        if abs(cylinder.Axis().Direction().Z()) > 0.999:
            centres.add((round(x, 6), round(y, 6)))
    return centres


def expected_centres(half_pitch):
    return {(sx * half_pitch, sy * half_pitch) for sx, sy in CORNERS}


def check(assembly):
    lid = assembly.objects['lid:1'].obj
    lifter = assembly.objects['lifter:1'].obj
    top = assembly.objects['top:1'].obj
    for name, shape, radius in (('lid', lid, 6.15),
                                ('lifter', lifter, 5.75),
                                ('top', top, 3.5)):
        if guide_centres(shape, radius) != expected_centres(69.0):
            raise ValueError(f'{name}: guide centres must be at X/Y = +/-69 mm')
    if not lid.isValid() or len(lid.Solids()) != 1:
        raise ValueError('Lid must be one valid solid')
    for name, other in (('lifter', lifter), ('top', top)):
        overlap = lid.intersect(other).Volume()
        if overlap > 1e-6:
            raise ValueError(f'Lid intersects {name}: {overlap:.6f} mm^3')
    print('PASS: 138 mm guide pitch; one valid lid solid; no lid/lifter/top overlap')


def repair_step(source):
    # Preserve the original STEP records, component names and placements.
    # Traverse each bore face to its cylinder/circle origins and seam vertices.
    records = {int(n): body for n, body in
               re.findall(r'#(\d+)\s*=\s*(.*?);', source, re.S)}

    def references(number):
        return [int(n) for n in re.findall(r'#(\d+)', records[number])]

    surfaces = {n for n, body in records.items()
                if body.startswith('CYLINDRICAL_SURFACE') and body.endswith(',6.15)')}
    faces = [n for n, body in records.items()
             if body.startswith('ADVANCED_FACE') and surfaces.intersection(references(n))]
    if len(surfaces) != 4 or len(faces) != 4:
        raise ValueError('Expected the four original 12.3 mm guide bores')
    replacements = {}
    centres = set()
    for face in faces:
        pending, descendants = [face], set()
        while pending:
            number = pending.pop()
            if number not in descendants:
                descendants.add(number)
                pending.extend(references(number))
        points = {n: records[n] for n in descendants
                  if records[n].startswith('CARTESIAN_POINT')}
        if len(points) != 6:
            raise ValueError('Unrecognized bore topology; expected six point records')
        for number, point in points.items():
            match = re.fullmatch(r"CARTESIAN_POINT\('([^']*)',\(([^)]+)\)\)", point)
            if not match:
                raise ValueError('Unrecognized point record')
            x, y, z = map(float, match[2].split(','))
            sx, sy = (1 if x > 0 else -1), (1 if y > 0 else -1)
            if z not in (63.0, 67.0) or abs(abs(y) - 68.7) > 1e-6:
                raise ValueError('Expected original bore points at Z=63/67 and Y=+/-68.7')
            if min(abs(x - sx * 68.7), abs(x - (sx * 68.7 + 6.15))) > 1e-6:
                raise ValueError('Unexpected bore X coordinate')
            centres.add((sx * 68.7, sy * 68.7))
            moved = f"CARTESIAN_POINT('{match[1]}',({x + sx * .3:.2f},{y + sy * .3:.2f},{z:.1f}))"
            replacements[number] = moved
    if centres != expected_centres(68.7) or len(replacements) != 24:
        raise ValueError('Expected 24 distinct point records across four corners')
    for number, body in replacements.items():
        original = f'#{number}={records[number]};'
        if source.count(original) != 1:
            raise ValueError('Unrecognized STEP formatting')
        source = source.replace(original, f'#{number}={body};')
    return source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('assembly', type=Path)
    parser.add_argument('--output', type=Path, help='Write corrected STEP here')
    parser.add_argument('--stl', type=Path, help='Write corrected lid STL here')
    args = parser.parse_args()
    if args.stl and not args.output:
        parser.error('--stl requires --output')
    original = cq.Assembly.importStep(str(args.assembly))
    if args.output:
        source = args.assembly.read_bytes().decode('utf-8')
        if guide_centres(original.objects['lid:1'].obj, 6.15) != expected_centres(69.0):
            source = repair_step(source)
        args.output.write_bytes(source.encode('utf-8'))
        corrected = cq.Assembly.importStep(str(args.output))
        if abs(corrected.objects['lid:1'].obj.Volume() - original.objects['lid:1'].obj.Volume()) > 1e-5:
            raise ValueError('Moving the bores unexpectedly changed the lid volume')
        check(corrected)
        if args.stl:
            corrected.objects['lid:1'].obj.exportStl(
                str(args.stl), tolerance=0.01, angularTolerance=0.2, relative=False
            )
    else:
        check(original)


if __name__ == '__main__':
    main()
