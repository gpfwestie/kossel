include <configuration.scad>;

height = 26;
height2 = 26;
tunnel = 2.4;
face_offset = 4;

module foot() {
  difference() {
    translate([12.5, 0, 0]) rotate([0, 0, -60])
      translate([-12.5, 0, 1]) rotate([0, 0, -60]) union() {
        cylinder(r=5, h=4, center=true, $fn=24);
        translate([10, 0, 0])
          cube([20, 10, 4], center=true);
    }
    translate([0, -10, 0])
      cube([40, 20, 20], center=true);
    translate([12.5, 0, 0]) {
      // Space for bowden push fit connector.
      cylinder(r=6.49, h=3*height, center=true, $fn=32);
      for (a = [60:120:359]) {
	    rotate([0, 0, a]) translate([-12.5, 0, 0])
          cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
      }
    }
  }
}

module feet()
{
    // Feet for vertical M3 screw attachment.
    rotate([0, 0, 90])
    {
        foot();
        scale([1, -1, 1])
            foot();
    }
}

module ir_mount()
{
    #difference()
    {
        cube([24.5,4,6.3]);
        translate([24.5/2-8.75,10,3.15])
            rotate([90,0,0])
                cylinder(r=no4_pilot_radius,h=20,$fn=12);
        translate([24.5/2+8.75,10,3.15])
            rotate([90,0,0])
                cylinder(r=no4_pilot_radius,h=20,$fn=12);
    }
}

module z_probe()
{
        union()
        {
            // Feet for vertical M3 screw attachment.
            feet();
            // Cutout for threaded rod
            difference()
            {
                translate([0,-13,6])
                    cube([10,4,8],center=true);
                translate([-5,-11,6.5])
                    rotate([90,0,90])
                        cylinder(r=2,h=10,$fn=20);
            }
            // Right angled arm
            translate([-5,-17, -1])
            {
                
                cube([10, 17, 4]);
                difference()
                {
                    cube([10, 4, 40+5]);
                    translate([0.5,0.5,22-16.5+14.5+5])
                    {
                        // Cutout for pins on bottom of pcb
                        #cube([9,3.5,9]);
                    }
                }
            }
            translate([-12.25,-17, 38+5])
            {
                ir_mount();
                  
            }
        }
        

}

//rotate([0,0,90])
//    z_probe();

