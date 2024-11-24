//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// May 2011
//=====================================

/*
	A set of math routines for graphics calculations

	There are many sources to draw from to create the various math
	routines required to support a graphics library.  The routines here
	were created from scratch, not borrowed from any particular 
	library already in existance.

	One great source for inspiration is the book:
		Geometric Modeling
		Author: Michael E. Mortenson

	This book has many great explanations about the hows and whys
	of geometry as it applies to modeling.

	As this file may accumulate quite a lot of routines, you can either
	include it whole in your OpenScad files, or you can choose to 
	copy/paste portions that are relevant to your particular situation.

	It is public domain code, simply to avoid any licensing issues.
*/

//=======================================
//				Constants
//=======================================
CGoldenRatio = 1.618; 

//=======================================
//
// 				Point Routines
//
//=======================================

// Create a point
function Point2D_Create(u,v) = [u,v]; 
function Point3D_Create(u,v,w) = [u,v,w];

//=======================================
//
// 				Vector Routines
//
//=======================================

// Basic vector routines
// Sum of two vectors
function VSUM(v1, v2) = [v1[0]+v2[0], v1[1]+v2[1], v1[2]+v2[2]];
function VSUB(v1, v2) = [v1[0]-v2[0], v1[1]-v2[1], v1[2]-v2[2]];

function VMULT(v1, v2) = [v1[0]*v2[0], v1[1]*v2[1], v1[2]*v2[2]];

// Magnitude of a vector
// Gives the Euclidean norm
function VLENSQR(v) = (v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);
function VLEN(v) = sqrt(VLENSQR(v));
function VMAG(v) = sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);


// Returns the unit vector associated with a vector
function VUNIT(v) = v/VMAG(v);
function VNORM(v) = v/VMAG(v);

// The scalar, or 'dot' product
// law of cosines
// if VDOT(v1,v2) == 0, they are perpendicular
function SPROD(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2];
function VDOT(v1v2) = SPROD(v1v2[0], v1v2[1]);

// The vector, or Cross product
// Given an array that contains two vectors
function VPROD(vs) = [
	(vs[0][1]*vs[1][2])-(vs[1][1]*vs[0][2]), 
	(vs[0][2]*vs[1][0])-(vs[1][2]*vs[0][0]),
	(vs[0][0]*vs[1][1])-(vs[1][0]*vs[0][1])];
function VCROSS(v1, v2) = VPROD([v1,v2]);

// Calculate the angle between two vectors
function VANG(v1, v2) = acos(VDOT([v1,v2])/(VMAG(v1)*VMAG(v2)));

// Calculate the rotations necessary to take a polygon, and apply 
// the rotate() transform, and get the polygon to be perpendicular to 
// the specified vector.
function rotations(v) = [ 
	VANG([0,1,0], [0,v[1],v[2]]), 
	VANG([0,0,-1], [v[0],0,v[2]]), 
	VANG([1,0,0], [v[0], v[1],0])];

// Get the appropriate rotations to place a cylinder in world space 
// This is helpful when trying to place a 'line segment' in space
// Book: Essential Mathematics for Games and Interactive Applications (p.75)
function LineRotations(v) = [
	atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]), 
	0, 
	atan2(v[1], v[0])+90];

// The following are already provided in OpenScad, but are
// here for completeness
function VMULTS(v, s) = [v[0]*s, v[1]*s, v[2]*s];
function VDIVS(v,s) = [v[0]/s, v[1]/s, v[2]/s];
function VADDS(v,s) = [v[0]+s, v[1]+s, v[2]+s];
function VSUBS(v,s) = [v[0]-s, v[1]-s, v[2]-s];


// Some more convenience routines.  Not found in OpenScad, but primarily using OpenScad routines
function VMIN(v1,v2) = [min(v1[0],v2[0]), min(v1[1],v2[1]), min(v1[2], v2[2])];
function VMIN3(v1, v2, v3) = VMIN(VMIN(v1,v2),v3);
function VMIN4(v1, v2, v3, v4) = VMIN(VMIN3(v1, v2, v3), v4);

function VMAX(v1,v2) = [max(v1[0],v2[0]), max(v1[1],v2[1]), max(v1[2], v2[2])];
function VMAX3(v1, v2, v3) = VMAX(VMAX(v1,v2),v3);
function VMAX4(v1, v2, v3, v4) = VMAX(VMAX(v1, v2, v3), v4);


//=======================================
//
// 			MATRIX Routines
//
//=======================================

function MADD2X2(m1, m2) = [
	[m1[0][0]+m2[0][0],  m1[0][1]+m2[0][1]],
	[m1[1][2]+m2[1][0],  m1[1][1]+m2[1][1]]];

// Returns the determinant of a 2X2 matrix
// Matrix specified in row major order
function DETVAL2X2(m) = m[0[0]]*m[1[1]] - m[0[1]]*m[1[0]];

// Returns the determinant of a 3X3 matrix
function DETVAL(m) = 
	m[0[0]]*DETVAL2X2([ [m[1[1]],m[1[2]]], [m[2[1]],m[2[2]]] ]) - 
	m[0[1]]*DETVAL2X2([ [m[1[0]],m[1[2]]], [m[2[0]],m[2[2]]] ]) + 
	m[0[2]]*DETVAL2X2([ [m[1[0]],m[1[1]]], [m[2[0]],m[2[1]]] ]);

//=======================================
//
// 			Helper Routines
//
//=======================================

function AvgThree(v1,v2,v3) = (v1+v2+v3)/3; 
function AvgFour(v1,v2,v3,v4) = (v1+v2+v3+v4)/4;

function CenterOfGravity3(p0, p1, p2) = [
	AvgThree(p0[0], p1[0], p2[0]), 
	AvgThree(p0[1], p1[1], p2[1]), 
	AvgThree(p0[2], p1[2], p2[2])];
function CenterOfGravity4(p0, p1, p2, p3) = [
	AvgThree(p0[0], p1[0], p2[0], p3[0]), 
	AvgThree(p0[1], p1[1], p2[1], p3[1]), 
	AvgThree(p0[2], p1[2], p2[2], p3[2])];

function lerp1(u, p0, p1) = (1-u)*p0 + u*p1;
function lerp(u, v1, v2) = [
	lerp1(u, v1[0], v2[0]),
	lerp1(u, v1[1], v2[2]),
	lerp1(u, v1[2], v2[2])
	];

 