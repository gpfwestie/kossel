include <configuration.scad>;
include <retractable.scad>;

pcb_hole_radius = 1;
pcb_standoff_radius = 2.8;
pcb_width = 30.5;
pcb_height = 50.5;

module standoff()
{
    cylinder(h=3,r=pcb_standoff_radius,$fn=20);
    cylinder(h=4.5,r=pcb_hole_radius,$fn=20);
}

module standoff_st()
{
    cylinder(h=3,r=pcb_standoff_radius,$fn=20);
}

module db9_mount()
{
difference()
{
    union()
    {
        cube([pcb_width,pcb_height,4]);
        translate([4.3,2.8,4])
        {
            standoff();
                translate([22,0,0])
                    standoff();
            translate([-1+6.2,34,0])
                    standoff();
            translate([-1,34,0])
                    standoff_st();
        }
    }
    translate([4.3-1,2.8+34,0])
        cylinder(h=7,r=no4_pilot_radius,$fn=20);
}
}

union()
{
    rotate([90,0,180])
        translate([-pcb_width/2,-pcb_height+3,-4])
            db9_mount();
    difference()
    {
        feet();
        translate([-5,-14,-4])
            cube([10,10,10]);
    }
}

