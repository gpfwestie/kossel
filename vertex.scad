include <configuration.scad>;

$fn = 24;
roundness = 6;

body1_cylinder_offset = 22;  //22
body2_cylinder_offset = -30; //-37

module extrusion_cutout(h, extra)
{
	difference()
	{
		cube([extrusion+extra, extrusion+extra, h], center=true);
		//for (a = [0:90:359]) rotate([0, 0, a])
		//{
		//	translate([extrusion/2, 0, 0])
		//		cube([6, 2.5, h+1], center=true);
		//}
	}
}

module screw_socket()
{
	cylinder(r=m3_wide_radius, h=15, center=true);
	translate([0, 0, 3.8]) cylinder(r=3.5, h=5);
}

module screw_socket_cone()
{
	union()
	{
		screw_socket();
		scale([1, 1, -1]) cylinder(r1=4, r2=7, h=4);
	}
}

module vertex(height, idler_offset, idler_space, fn=180)
{
	translate([0,2.5,0])
		union()
		{
			// Pads to improve print bed adhesion for slim ends.
			translate([-37.5, 52.2, -height/2])
				cylinder(r=8, h=0.4);
			translate([37.5, 52.2, -height/2])
				cylinder(r=8, h=0.4);

			difference()
			{
				union()
				{
				     intersection()
				     {
                        translate([0, body1_cylinder_offset, 0])
                            cylinder(r=vertex_radius, h=height, center=true, $fn=fn*2);
                        translate([0, body2_cylinder_offset, 0])
                            rotate([0, 0, 30])
                                cylinder(r=50, h=height+1, center=true, $fn=6);
				     }
				     translate([0, 38, 0])
                        intersection() 
                        {
                            rotate([0, 0, -90])
                                cylinder(r=55, h=height, center=true, $fn=3);
                            translate([0, 10, 0])
                                cube([100, 100, 2*height], center=true);
                            translate([0, -10, 0])
                                rotate([0, 0, 30])
                                    cylinder(r=55, h=height+1, center=true, $fn=6);
                        }
                }
				difference() 
				{   
				    translate([0, 58, 0])
                        minkowski()
                        {
                            intersection() 
                            {
                                rotate([0, 0, -90])
                                    cylinder(r=55, h=height, center=true, $fn=3);
                                translate([0, -31, 0])  cube([100, 15, 2*height], center=true);
                            }
                            cylinder(r=roundness, h=1, center=true);
                        }

                    // Idler support cones.
                    translate([0, 26+idler_offset-30, 0])
                        rotate([-90, 0, 0])
                            cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
                    translate([0, 26+idler_offset+30, 0])
                        rotate([90, 0, 0])
                            cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
                }
                translate([0, 58, 0]) minkowski() 
                {
                    intersection() 
                    {
                        rotate([0, 0, -90])
                            cylinder(r=55, h=height, center=true, $fn=3);
                        translate([0, 7, 0])
                            cube([100, 30, 2*height], center=true);
                    }
                    cylinder(r=roundness, h=1, center=true);
                }

            translate([0,-2.5,0])
                extrusion_cutout(height+10, 0.15);

            for (z = [-height/2 + extrusion/2 , height/2 - extrusion/2] ) 
            {
                translate([0, -extrusion/2-extra_radius+extrusion_fin_d-2.5, z])
                    rotate([90, 0, 0])
                        screw_socket_cone();
                for (a = [-1, 1]) 
                {
                    rotate([0, 0, 30*a])
                        translate([-(vertex_radius-body1_cylinder_offset)*a, 111, z]) 
                        {
                            //% rotate([90, 0, 0]) extrusion_cutout(200, 0);
                            // Screw sockets.
                            for (y = [-88, -44]) 
                            {
                                translate([a*(extrusion/2-0.6), y, 0])
                                    rotate([0, a*90, 0])
                                        screw_socket();
                            }

                            // Nut tunnels.
                            for (z = [-1, 1]) 
                            {
                                scale([1, 1, z]) 
                                    translate([0, -99, 3]) 
                                        minkowski() 
                                        {
                                            rotate([0, 0, -a*30])
                                                cylinder(r=5, h=16); //cylinder(r=m3_nut_radius, h=16);
                                            cube([0.1, 8, 0.1], center=true);
                                        }
                            }  
                        }
                }
            }
        }
    }
}



translate([0, 0, extrusion*2.5/2]) 
    vertex(extrusion*2.5, idler_offset=0, idler_space=10, fn=20 );

//translate([0, 0, 7.5]) vertex_cover(3);



