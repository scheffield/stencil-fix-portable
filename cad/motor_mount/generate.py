"""Generate the optional removable motor mount; requires cadquery==2.8.0."""

import argparse
from itertools import product
from math import sqrt
from pathlib import Path

import cadquery as cq
from OCP.BRepAdaptor import BRepAdaptor_Surface


BOLTS = ((28, 0), (-28, 0), (0, 28), (0, -28))
ORIGINAL_HALF_PITCH = 9.5 / sqrt(2)  # 19 mm bolt circle, rotated 45 degrees.
PATTERNS = {'19mm_pcd': ORIGINAL_HALF_PITCH, '16mm_square': 8.0}


def cylinder(radius, bottom, height, x=0, y=0):
    return cq.Solid.makeCylinder(radius, height, cq.Vector(x, y, bottom))


def holes(shape, radius, bottom, top):
    found = set()
    for face in shape.Faces():
        if face.geomType() != 'CYLINDER':
            continue
        c = BRepAdaptor_Surface(face.wrapped).Cylinder()
        b = face.BoundingBox()
        if (abs(c.Radius() - radius) < 1e-5
                and abs(c.Axis().Direction().Z()) > .999
                and abs(b.zmin - bottom) < 1e-5
                and abs(b.zmax - top) < 1e-5):
            x, y, _ = c.Location().Coord()
            found.add((round(x, 5), round(y, 5)))
    return found


def pattern(half_pitch):
    return {(round(x, 5), round(y, 5))
            for x, y in product((-half_pitch, half_pitch), repeat=2)}


def check_solid(name, shape):
    if not shape.isValid() or len(shape.Solids()) != 1:
        raise ValueError(f'{name} must be one valid solid')


def check_fit(base, adapter, half_pitch):
    check_solid('base', base)
    check_solid('adapter', adapter)
    if base.intersect(adapter).Volume() > 1e-6:
        raise ValueError('Base and adapter intersect')
    if holes(adapter, 1.65, 10, 20) != pattern(half_pitch):
        raise ValueError('Unexpected motor screw pattern')
    if holes(adapter, 1.65, 10, 14) != set(BOLTS):
        raise ValueError('Unexpected flange screw pattern')
    if holes(base, 2.1, 6, 10) != set(BOLTS):
        raise ValueError('Unexpected insert pattern')
    if not any(f.geomType() == 'PLANE' and abs(f.BoundingBox().zmin - 20) < 1e-6
               and abs(f.BoundingBox().zmax - 20) < 1e-6 and f.Area() > 500
               for f in adapter.Faces()):
        raise ValueError('Motor seating plane must remain at Z=20 mm')
    # Nominal M3x10 flange screws: head above Z=14, shaft down to Z=4.
    for x, y in BOLTS:
        screw = cylinder(1.5, 4, 10, x, y).fuse(cylinder(2.75, 14, 3, x, y))
        if screw.intersect(base).Volume() + screw.intersect(adapter).Volume() > 1e-6:
            raise ValueError('Flange screw envelope intersects printed material')
    print('PASS: valid solids, aligned screw/insert patterns, Z=20 motor seat, no interference')


def generate(original):
    if holes(original, 1.65, 10.4, 20) != pattern(ORIGINAL_HALF_PITCH):
        raise ValueError('Expected the original 19 mm bolt-circle motor mount')
    # Leave the 2 mm floor beneath the cartridge, with central screwdriver
    # access. Relieve the existing ribs around the hub and its new flange.
    base = original.cut(cylinder(22.25, 2, 25), cylinder(32.25, 10, 4.25),
                        cylinder(15, -1, 3)).clean()
    for x, y in BOLTS:
        base = base.fuse(cylinder(4.5, 2, 8, x, y)).cut(
            cylinder(2.1, 6, 4, x, y), cylinder(1.65, 2, 4, x, y)
        ).clean()
    hub = original.intersect(cylinder(22, 2, 24)).clean()
    # Remove the original bore/bridge geometry before drilling either variant.
    for x, y in product((-ORIGINAL_HALF_PITCH, ORIGINAL_HALF_PITCH), repeat=2):
        hub = hub.fuse(cylinder(2.9, 2, 18, x, y)).clean()
    parts = {'base_modular': base}
    for name, half_pitch in PATTERNS.items():
        adapter = hub.fuse(cylinder(32, 10, 4)).clean()
        for x, y in product((-half_pitch, half_pitch), repeat=2):
            adapter = adapter.cut(cylinder(2.9, 2, 8, x, y),
                                  cylinder(1.65, 10, 10, x, y)).clean()
        for x, y in BOLTS:
            adapter = adapter.cut(cylinder(1.65, 10, 4, x, y)).clean()
        check_fit(base, adapter, half_pitch)
        parts[f'motor_mount_{name}'] = adapter
    return parts


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path,
                        default=Path(__file__).resolve().parents[1] / 'stencil_fix_portable.step')
    parser.add_argument('--output-dir', type=Path, default=Path(__file__).resolve().parent)
    args = parser.parse_args()
    original = cq.Assembly.importStep(str(args.source)).objects['base:1'].obj
    parts = generate(original)
    args.output_dir.mkdir(parents=True, exist_ok=True)
    for name, shape in parts.items():
        step = args.output_dir / f'{name}.step'
        shape.exportStep(str(step), write_pcurves=False)
        # Whitespace from the STEP writer is insignificant; keep Git checks useful.
        step.write_text('\n'.join(line.rstrip() for line in step.read_text().splitlines()) + '\n')
        shape.exportStl(str(args.output_dir / f'{name}.stl'),
                        tolerance=.02, angularTolerance=.2, relative=False)
    roundtrip = {name: cq.importers.importStep(str(args.output_dir / f'{name}.step')).val()
                 for name in parts}
    for name, half_pitch in PATTERNS.items():
        check_fit(roundtrip['base_modular'], roundtrip[f'motor_mount_{name}'], half_pitch)


if __name__ == '__main__':
    main()
