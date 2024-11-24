//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <maths.scad>
include <bezier.scad>


//=========================================
//
// 			Functions
//
//=========================================

function parseSeg(seg) = [ 
	seg[0], 
	LineRotations(seg[1]-seg[0]), 
	VMAG(seg[1]-seg[0])
	];

function GetPlaneVectors(points) = [points[2]-points[1],points[0]-points[1]];

//function LineRotations(v) = [ 
//	atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]), 
//	0, 
//	atan2(v[1], v[0])+90];

function quadtrans(quad, trans) = [ 
	VSUM(quad[0], trans), 
	VSUM(quad[1], trans),
	VSUM(quad[2], trans),
	VSUM(quad[3], trans)];

//=========================================
//
// 			Modules
//
//=========================================
module PlaceLine(seg, radius=0.025) 
{
	params = parseSeg(seg);

//echo("Segment: ", params,r);

	origin = params[0];
	rot = params[1];
	len = params[2];

//echo("ORIGIN ", params[0]);
//echo("ROTATION: ", rot);
//echo("LENGTH: ",len);

	translate(origin)
	rotate(rot)
	cylinder(r=radius, h=len, $fn=12);
}

// Display a polyhedron with some thickness 
module DisplayTriShard(shard)
{
polyhedron(
points=[
shard[0][0], shard[0][1],shard[0][2], // Top
shard[1][0], shard[1][1], shard[1][2]], // Bottom
triangles=[
[0,2,1],
[3,4,5],
[1,5,4],
[1,2,5],
[2,3,5],
[2,0,3],
[0,4,3],
[0,1,4]
]);
}

module DisplayQuadShard(quad, thickness=1) 
{
	lowquad = quadtrans(quad, [0,0,-thickness]);
//echo("QUAD: ", quad);
//echo("LOW QUAD: ", lowquad);

	DisplayTriShard([[quad[0],quad[1],quad[2]],
		[lowquad[0], lowquad[1], lowquad[2]]]);

	DisplayTriShard([[quad[0],quad[2],quad[3]],
		[lowquad[0], lowquad[2], lowquad[3]]]);
}

//========================================
//		Bezier Display Routines
//========================================

// This function will extrude a bezier solid from a bezier curve 
// It is a straight up prism
// c - ControlPoints
//
module BezFillet(c, focalPoint, steps=gSteps, height=gHeight)
{
	for(step = [steps:1])
	{
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				focalPoint,
				PtOnBez2D(c[0], c[1], c[2],c[3], step/steps),
				PtOnBez2D(c[0], c[1], c[2],c[3], (step-1)/steps)],
			paths=[[0,1,2,0]]
		);
	}
}

module BezCubicFilletColored(c, focalPoint, steps=gSteps, height=gHeight, colors)
{
	for(step = [steps:1])
	{
		color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
		linear_extrude(height = height, convexity = 10) 
		polygon(
		points=[
		focalPoint,
		PointOnBezCubic2D(c[0], c[1], c[2],c[3], step/steps),
		PointOnBezCubic2D(c[0], c[1], c[2],c[3], (step-1)/steps)],
		paths=[[0,1,2,0]]
		);
	}
}


module BezCubicRibbon(c1, c2, steps=gSteps, height=gHeight, colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]])
{
for (step=[0:steps-1])
{
color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
linear_extrude(height = height, convexity = 10) 
polygon(
points=[
PtOnBez2D(c1[0], c1[1], c1[2],c1[3], step/steps),
PtOnBez2D(c2[0], c2[1], c2[2],c2[3], (step)/steps),
PtOnBez2D(c2[0], c2[1], c2[2],c2[3], (step+1)/steps),
PtOnBez2D(c1[0], c1[1], c1[2],c1[3], (step+1)/steps)],
paths=[[0,1,2,3]]
);

}
}

module BezCubicRibbonRotate(c1, c2, steps=gSteps, height=gHeight, colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]])
{
for (step=[0:steps-1])
{
color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
rotate_extrude(convexity=10) 
polygon(
points=[
PtOnBez2D(c1[0], c1[1], c1[2],c1[3], step/steps),
PtOnBez2D(c2[0], c2[1], c2[2],c2[3], (step)/steps),
PtOnBez2D(c2[0], c2[1], c2[2],c2[3], (step+1)/steps),
PtOnBez2D(c1[0], c1[1], c1[2],c1[3], (step+1)/steps)],
paths=[[0,1,2,3]]
);
}
}


module bezierMesh(mesh,
	colors=[[1,1,0],[1,1,0],[1,1,0],[1,1,0]], 
	usteps=4, wsteps=4)
{
	for (ustep = [0:usteps-1]) 
	{
		for (wstep=[0:wsteps-1])
		{
			assign(ufrac1 = ustep/usteps)
			assign(ufrac2 = (ustep+1)/usteps)
			assign(wfrac1=wstep/wsteps)
			assign(wfrac2=(wstep+1)/wsteps)
			assign(quad = GetCurveQuad(mesh, [ufrac1,wfrac1], [ufrac2,wfrac2]))
			{
//echo("FRACTIONS U1,V1: ", ufrac1, vfrac1);
//echo("FRACTIONS U2,V2: ", ufrac2, vfrac2);
//echo("QUAD: ", quad);
			
				PlaceQuad(quad);
			}
		}
	}
}

module DisplayBezSurface(mesh, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]], 
	steps=4, thickness=1)
{
	for (ustep = [0:steps-1])
	{
		for (vstep=[0:steps-1])
		{
			assign(ufrac1 = ustep/steps)
			assign(ufrac2 = (ustep+1)/steps)
			assign(vfrac1=vstep/steps)
			assign(vfrac2=(vstep+1)/steps)
			assign(quad = GetCurveQuad(mesh, [ufrac1,vfrac1], [ufrac2,vfrac2]))
			{
//color([acolor[0], acolor[1], acolor[2], ufrac1/vfrac2])
				color(PtOnBez(colors, vfrac1))
				DisplayQuadShard(quad, thickness=thickness);
			}
		}
	}
}

//module bezierMeshPoints(lcp1, lcp2, lcp3, lcp4,
//	colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], 
//	granuleSize = gGranuleSize, usteps=4, vsteps=4)
//{
//	for (ustep = [0:usteps-1])
//	{
//		assign(ufrac1 = ustep/usteps)
//		assign(ufrac2 = (ustep+1)/usteps)
//		assign(c1u1 =  PtOnBez(lcp1, ufrac1))
//		assign(c2u1 =  PtOnBez(lcp2, ufrac1))
//		assign(c3u1 =  PtOnBez(lcp3, ufrac1))
//		assign(c4u1 =  PtOnBez(lcp4, ufrac1))
//
//		assign(c1u2 =  PtOnBez(lcp1[0],lcp1[1], lcp1[2], lcp1[3], ufrac2))
//		assign(c2u2 =  PtOnBez(lcp2[0],lcp2[1], lcp2[2], lcp2[3], ufrac2))
//		assign(c3u2 =  PtOnBez(lcp3[0],lcp3[1], lcp3[2], lcp3[3], ufrac2))
//		assign(c4u2 =  PtOnBez(lcp4[0],lcp4[1], lcp4[2], lcp4[3], ufrac2))
//		{
//			for(vstep=[0:vsteps-1])
//			{
//				assign(vpt = PointOnBezCubic3D(c1u1, c2u1, c3u1, c4u1, vstep/vsteps))
//				translate(vpt)
//				sphere(r=0.75);
//			}
//		}
//	}
//}

module bezierMeshSolid(mesh,
	colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], 
	granuleSize = [1,1,1], 
	usteps=100, vsteps=100)
{
	for (ustep = [0:usteps])
	{
		for(vstep=[0:vsteps])
		{
			assign(ufrac = ustep/usteps)
			assign(vfrac = vstep/vsteps)
			assign(vpt = PtOnBezMesh(mesh, [ufrac,vfrac]))
			{
				//echo(vpt);
				translate([vpt[0], vpt[1], vpt[2]])
				cube(size=[1,1,vpt[2]]);
			}
		}
	}
}