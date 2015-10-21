include <configuration.scad>;

mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
//hotend_recess = 4.7;  // How much to sink the hotend into the effector
hotend_inner_radius = 5.95;  // Rim around it stops the hotend moving upwards
height = 4.6; // Height of slot in hotend

module effector() {
  difference() {
    union() {
      cylinder(r=mount_radius + mount_radius - hotend_radius, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
      }
    }
    // Hole to clip into hote end
    translate([0, 0, -height/2])
      cylinder(r=hotend_inner_radius, h=height, $fn=36);
    
    // Mounting holes and nut traps
    for (a = [0:60:359]) rotate([0, 0, a])
    {
        translate([0, mount_radius, 0])
            cylinder(r=m3_wide_radius, h=height, center=true, $fn=12);
        translate([0, mount_radius,thickness-m3_nyloc_h])
			cylinder(r=m3_nut_radius,h=m3_nyloc_h+1,$fn=6);
               
    }
  }
}

difference()
{
    effector();
    rotate([0,0,30])
        translate([(mount_radius + mount_radius - hotend_radius)/2,0,0])
            cube([mount_radius + mount_radius - hotend_radius,(hotend_inner_radius*2)*.95,height],center=true);
    
}
//translate([0, 0, height/2]) effector();
