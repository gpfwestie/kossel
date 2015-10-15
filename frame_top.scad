include <configuration.scad>;

use <vertex.scad>;

$fn = 240;

module frame_top() {
  difference() {
    vertex(extrusion+0.1, idler_offset=3, idler_space=12.5, fn=280);
    // M3 bolt to support idler bearings.
    translate([0, 65, 0]) rotate([90, 0, 0]) cylinder(r=m3_radius, h=55);
    
    // Vertical belt tensioner.
    translate([0, 13, 0]) rotate([12, 0, 0]) union() {
      cylinder(r=m3_wide_radius, h=30, center=true);
      translate([0, -4.25, 8]) rotate([-12,0,0])cube([5.6, 6, 8], center=true);
      %translate([0, 0, 2.5]) scale([1, 1, -1]) rotate([0, 0, 0])   cylinder(r1=m3_nut_radius, r2=m3_nut_radius, h=15, $fn=6);
    }
   //sink innner belt pulley screw
   translate([0,49-thickness,(extrusion/2)/2-5])rotate([90,0,0])cylinder(h=5, r=3, center=true);

  }
}

translate([0, 0, extrusion/2]) frame_top();
