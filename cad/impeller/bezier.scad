//=====================================
// This is public Domain Code
// Contributed by: William A Adams
// 25 May 2011
//=====================================


//=======================================
//
//			 Functions
//
//=======================================

/*
	Bernstein Basis Functions

	For Bezier curves, these functions give the weights per control point.
	
*/
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);


// Calculate a singe point along a cubic bezier curve
// Given a set of 4 control points, and a parameter 0 <= 'u' <= 1
// These functions will return the exact point on the curve
function PtOnBez2D(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

// Given an array of control points
function PtOnBez(cps, u) = 
	[BEZ03(u)*cps[0][0]+BEZ13(u)*cps[1][0]+BEZ23(u)*cps[2][0]+BEZ33(u)*cps[3][0],
	BEZ03(u)*cps[0][1]+BEZ13(u)*cps[1][1]+BEZ23(u)*cps[2][1]+BEZ33(u)*cps[3][1],
	BEZ03(u)*cps[0][2]+BEZ13(u)*cps[1][2]+BEZ23(u)*cps[2][2]+BEZ33(u)*cps[3][2]];

// Calculate a point on a Bezier mesh
// Given the mesh, and the parametric 'u', and 'v' values
function PtOnBezMesh(mesh, uv) = PtOnBez(
	[PtOnBez(mesh[0], uv[0]), PtOnBez(mesh[1], uv[0]),
	PtOnBez(mesh[2], uv[0]), PtOnBez(mesh[3], uv[0])], 
	uv[1]);

// Given a mesh of control points, and an array that contains the 
// row and column of the quad we want, return the quad as an 
// ordered set of points.  The winding will be counter clockwise
function GetControlQuad(mesh, rc) = [ 
	mesh[rc[0]+1][rc[1]], 
	mesh[rc[0]][rc[1]], 
	mesh[rc[0]][rc[1]+1], 
	mesh[rc[0]+1][rc[1]+1]
];


// Given a mesh, and the 4 parametric points, return a quad that has the appropriate 
// points along the curve, in counter clockwise order
function GetCurveQuad(mesh, u1v1, u2v2) = [
	PtOnBezMesh(mesh, [u1v1[0],u2v2[1]]), 
	PtOnBezMesh(mesh, u1v1),
	PtOnBezMesh(mesh, [u2v2[0],u1v1[1]]), 
	PtOnBezMesh(mesh, u2v2)];
