include <configuration.scad>;

height = 2;

difference()
{
    union()
    {
        cube([39,16,height]);
        translate([-4.5,0,0])
        {
            cube([28,24,height]);
        }
        /*translate([2.5+18.5-2-10-2,0,-10])
        {
            cube([4,16,10]);
        }
        translate([2.5+18.5-2+10,0,-10])
        {
            cube([4,16,10]);
        }*/
        translate([2.5,2.5,0])
        {
            cylinder(r=2, h=height+2, $fn=50);
            cylinder(r=m3_radius, h=height+3.75, $fn=50);
        }
        translate([34+2.5,2.5,0])
        {
            cylinder(r=2, h=height+2, $fn=50);
            cylinder(r=m3_radius, h=height+3.75, $fn=50);
        }
        translate([2.5,16-2.5,0])
        {
            cylinder(r=2, h=height+2, $fn=50);
        }
        translate([2.5+19,2.5,0])
        {
            cylinder(r=2, h=height+2, $fn=50);
        }
        translate([34+2.5,16-2.5,0])
        {
            cylinder(r=2, h=height+2, $fn=50);
            cylinder(r=m3_radius, h=height+3.75, $fn=50);
        }
    }
    translate([2.5+19,2.5,0])
    {
        cylinder(r=no4_pilot_radius,h=10,$fn=50);
    }
    translate([2-4.5,20,-5])
    {
        cylinder(r=no4_pilot_radius, h=10, $fn=50);
    }
    translate([10-0.5,20,0])
    {
        translate([0,0,height-1.2])
        {
            cylinder(r=3.5,h=1.2,$fn=50);
        }
        cylinder(r=m3_radius,h=10,$fn=50);
        
    }
}