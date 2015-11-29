include <configuration.scad>;

height=16;
$fn=50;

module psu()
{
    cube([65,100.5,125.5]);
    translate([65/2-2 + 51.5/2,110.5,6])
    rotate([90,0,0])
        cylinder(h=10,r=2);
    translate([65/2-2 - 51.5/2,110.5,6])
    rotate([90,0,0])
        cylinder(h=10,r=2);
    //51.5, m4
    //6mm
}

module extrusion()
{
    cube([extrusion,extrusion,200]);
}

module mount()
{
    hull()
    {
        translate([0,8,0])
            cylinder(h=8,r=8);
        translate([65+extrusion,100.5-40,0])
            cylinder(h=height,r=8);
        translate([extrusion,100.5-40,0])
            cylinder(h=height,r=8);    
    }
    translate([0,extrusion,0])
    {
        difference()
        {
            cube([extrusion,8,40]);
            translate([extrusion/2,extrusion,19])
                rotate([90,0,0])
                    cylinder(h=50,r=1.5);
            translate([extrusion/2,extrusion,32])
                rotate([90,0,0])
                    cylinder(h=50,r=1.5);
        }
    }
    
}

//psu();
difference()
{
    translate([0,0,-4])
        mount();
    translate([extrusion,-40,0])
        #psu();
    translate([0,0,-30])
        extrusion();
}
