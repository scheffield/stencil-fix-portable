//===================================== 
// This is Public Domain Code
// Contributed by: Christophe Augier
// 27 February 2014
//=====================================

// from https://www.thingiverse.com/thing:259773/files

use <Renderer.scad>;
use <BezierScad.scad>;

$fn=64; // general precision (used for the extruded body)
blade_precision = 20; // set to higher (height) for a better precision, keep low (4) for faster rendering

height = 25;  // height of the impeller
radius = 40;  // radius of the impeller
inlet_size = 20;  // size (radius) of the inflow
outlet_size = 5;  // size (height) of the outflow
inner_radius = 7;  // radius for the center shaft
control_point = [1, 4];  // control point to change curve
use_head = false;  // render a spherical head at the tip of the impeller
thickness = 2; // thickness of the base

n_blades = 6;  // number of blades
main_blade_height = height;  // height of main blades
blade_thickness = 2;  // blade thickness

use_splitters = true;  // render splitter blades
splitter_blade_height = height * 0.5; // height of splitter blades
splitter_offset_angle = -3;  // add angle offset relative to main blade

// The following sets of points define the blade profiles.
// You should only need to edit the last value (z) to change
// the curve of the blade.
// The first line is the bottom of the blade, the last line the
// top of the blade.

main_blade_points = [
  [[0, 0, 0],
   [radius * 2 / 4, 0, 0],
   [radius * 3 / 4, 0, 5],
   [radius, 0, 10]],
  [[0, main_blade_height * 2 / 4,0],
   [radius * 2 / 4, main_blade_height * 2 / 4, 0],
   [radius * 3 / 4, main_blade_height * 2 / 4, 0],
   [radius, main_blade_height * 2 / 4, 0]],
  [[0, main_blade_height * 3 / 4,0],
   [radius * 2 / 4, main_blade_height * 3 / 4, 0],
   [radius * 3 / 4, main_blade_height * 3 / 4, 0],
   [radius, main_blade_height * 3 / 4, 0]],
  [[0, main_blade_height, 0],
   [radius * 2 / 4, main_blade_height, -20],
   [radius * 3 / 4, main_blade_height, -20],
   [radius, main_blade_height, -20]]];

splitter_blade_points = [
  [[0, 0, 0],
   [radius * 2 / 4, 0, 0],
   [radius * 3 / 4, 0, 4],
   [radius, 0, 4]],
  [[0, splitter_blade_height * 2 / 4, 0],
   [radius * 2 / 4, splitter_blade_height * 2 / 4, 0],
   [radius * 3 / 4, splitter_blade_height * 2 / 4, 2],
   [radius, splitter_blade_height * 2 / 4, 2]],
  [[0, splitter_blade_height * 3 / 4,0],
   [radius * 2 / 4, splitter_blade_height * 3 / 4, 0],
   [radius * 3 / 4, splitter_blade_height * 3 / 4, -2],
   [radius, splitter_blade_height * 3 / 4, -2]],
  [[0, splitter_blade_height, 0],
   [radius * 2 / 4, splitter_blade_height, 0],
   [radius * 3 / 4, splitter_blade_height, -4],
   [radius, splitter_blade_height, -4]]];

// Uncomment the two following lines to render the main blade
// and the splitter blade profiles.
//main_blade();
//splitter_blade();

// Uncomment the two following lines to render the base body
// and the upper body profiles.
//base();
//upper_body();

// Uncomment the following line to render the impeller.
impeller();

module main_blade() {
 render()
  rotate([90, 0, 0])
   DisplayBezSurface(main_blade_points, 
	 colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	 steps=blade_precision, thickness=blade_thickness);
}

module splitter_blade() {
 render()
  rotate([90, 0, 0])
   DisplayBezSurface(splitter_blade_points, 
	 colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	 steps=blade_precision, thickness=blade_thickness);
}

module base() {
 union() {
  rotate_extrude()
   union() {
    polygon([[0, -thickness], [0, height],
             [inner_radius, height],
             [inner_radius, 0],
             [radius, 0],
             [radius, -thickness]]);
    translate([inner_radius, 0, 0])
     BezArc([[0, height], control_point,
             [radius-inner_radius, 0]], [0, 0],
             steps=12, height=0);
   }
  if (use_head) {
    translate([0, 0, height]) sphere(r=inner_radius);
  }
 }
}

module upper_body() {
 margin = 10;
 //projection(cut=true)rotate([90,0,0]) // to export the inlet as svg
 rotate_extrude()
  translate([inner_radius+inlet_size, outlet_size, 0])
   difference() {
    polygon([[0, 0], [0, height+margin],
             [radius-inner_radius-inlet_size+margin, height+margin],
             [radius-inner_radius-inlet_size+margin, -outlet_size-margin],
             [radius-inner_radius-inlet_size, -outlet_size-margin],
             [radius-inner_radius-inlet_size, 0]]);
    BezArc([[0, height], control_point,
            [radius-inner_radius-inlet_size, 0]], [0, 0],
            steps=12, height=0);
  }
}

module impeller() {
 difference() {
  union() {
   base();
   for (i = [0:n_blades]) {
    rotate(i * 360 / n_blades, [0, 0, 1])
     main_blade();
   }
   if (use_splitters) {
    for (i = [0:n_blades]) {
     rotate((i+0.5) * 360 / n_blades + splitter_offset_angle, [0, 0, 1])
      splitter_blade();
    }
   }
  }
  upper_body();
 }
}
