include <configuration.scad>;

height = 2; // Height of base

standoff_h = 2; // Height of standoffs
standoff_r = 2.5; // Radius of standoffs

pcb = 1.75; // Thickness of PCB
pcb_width = 39;
pcb_height = 16;

$fn=50;

module pcb_mount() // Mount for a Makerbot 1.2 Mechanical Endstop, uses No 4 Self Tapper
{
	difference()
	{
		union()
		{
			cube([pcb_width,pcb_height, height]);
			translate([2.5, 2.5, 0])
			{
				cylinder(r = standoff_r, h = height + standoff_h, $fn = 50);
				cylinder(r = m3_radius, h = height + standoff_h + pcb , $fn = 50);
			}
			translate([34 + 2.5, 2.5, 0])
			{
				cylinder(r = standoff_r, h = height + standoff_h, $fn = 50);
				cylinder(r = m3_radius, h = height + standoff_h + pcb, $fn = 50);
			}
			translate([2.5, 16 - 2.5, 0])
			{
				cylinder(r = standoff_r, h = height + standoff_h, $fn = 50);
			}
			translate([2.5 + 19, 2.5, 0])
			{
				cylinder(r = standoff_r, h = height + standoff_h, $fn = 50);
			}
			translate([34 + 2.5, 16 - 2.5, 0])
			{
				cylinder(r = standoff_r, h = height + standoff_h, $fn = 50);
				cylinder(r = m3_radius, h = height + standoff_h + pcb, $fn = 50);
			}
		}
		translate([2.5 + 19, 2.5, 0])
		{
			cylinder(r = no4_pilot_radius, h = 10, $fn = 50);
		}
	}
}

module holes(height = height,recess = 0)
{
	translate([2, 20, 0])
	{
		translate([0, 0, height - recess])
		{
			cylinder(r = 3.5, h = recess, $fn = 50);
		}
		translate([0, 0, -4])
			cylinder(r = no4_pilot_radius, h = 10, $fn = 50);
	}
	translate([28/2, 20, 0])
	{
		translate([0, 0, height - recess])
		{
			cylinder(r = 3.5, h = recess, $fn = 50);
		}
		cylinder(r = m3_radius, h = 10, $fn = 50);

	}
	translate([26,2.5,-4])
	{
		cylinder(r=no4_pilot_radius,h=10,$fn=50);
	}
}

module top_curve(top_height = height+standoff_h)
{
	hull()
	{
		translate([2,20,0])
			cylinder(r=4,h=top_height);
		translate([16,10,0]) 
			cylinder(r=4,h = height);
		difference()
		{
			translate([28/2,14,0]) 
				cylinder(r=14,h=top_height);
			cube([28, 16, top_height]);
		}
	}
}

module pcb_holder()
{
	hull()
	{
		translate([2,2,0])
			cylinder(r=2,h=height);
		translate([pcb_width+2.5,2,0]) 
			cylinder(r=2,h = height);
		translate([pcb_width+2.5,14,0]) 
			cylinder(r=2,h=height);
		translate([2,14,0]) 
			cylinder(r=2,h=height);
	}    
}

module endstop()
{
	difference()
	{
		union()
		{
			pcb_holder();
			top_curve();
			translate([4.5, 0, 0])
			{
				pcb_mount();
			}
		}
		holes(height + standoff_h,1.2);
	}
}

module support()
{
	difference()
	{
		union()
		{
			union()
			{
				top_curve(height);
				pcb_holder();
			}
			hull()
			{
				translate([26,2,-4])
					cylinder(r=2,h=4);
				translate([26,17,-4])
					cylinder(r=2,h=4);
			}
			hull()
			{
				translate([2,2,-4])
				{
					cylinder(r=2,h=4);
				}
				translate([2,20,-4])
				{
					cylinder(r=2,h=4);
				}
			}        
		}
		holes(0);    
	}
}

	rotate([180,0,0])
translate([0,0,-height])
	support();
translate([0,10,0])
	endstop();

	//top_curve();
	//pcb_holder();
	//pcb_mount();
