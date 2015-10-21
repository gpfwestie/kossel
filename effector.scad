include <configuration.scad>;

offset = 24;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
hotend_recess = 4.7;  // How much to sink the hotend into the effector
push_fit_radius = 6;  // Rim around it stops the hotend moving upwards
height = 8;
cone_r1 = 3.5;
cone_r2 = 14;

// The size of the nuts and bolts holding the spider arms
bolt_radius = m4_radius;
nut_radius = m4_nut_radius;


module effector() {
  difference() {
    union() {
      cylinder(r=offset-3, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-6, 0, 0])
	  cube([10, 19, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=bolt_radius, h=separation+1, center=true, $fn=12);
	    //rotate([90, 0, 90])
	    //  cylinder(r=nut_radius, h=separation-24, center=true, $fn=6);
	  }
        }
      }
    }
    // Recess for hotend
    translate([0, 0, -height/2])
      cylinder(r=hotend_radius, h=hotend_recess, $fn=36);
    // Hole for push fit connector to go through
    translate([0, 0, -height/2])
      cylinder(r=push_fit_radius, h=height, $fn=36);
    
    for (a = [0:60:359]) rotate([0, 0, a]) {
        translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}

effector();
//translate([0, 0, height/2]) effector();
