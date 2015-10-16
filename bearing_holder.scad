include <configuration.scad>;

$fn = 240;
idler_space = 10;

module nut()
{
    difference()
    {
        cylinder(r=m3_nut_radius,h=m3_nut_h,$fn=6);
       // cylinder(h=10,r=1.5);
    }
}

module bearing()
{
    difference()
    {
        union()
        {
            cylinder(h=1,r=11.5/2);
            cylinder(h=4,r=5);
        }
        //cylinder(h=10,r=1.5);
    }
}

module support_cones()
{
    // Idler support cones.
    translate([0, 0, -30+idler_space/2-m3_nut_h])
        cylinder(r1=30, r2=2, h=30-idler_space/2);
    translate([0, 0,30-idler_space/2+8+m3_nut_h])
        rotate([180,0,0])
            cylinder(r1=30, r2=2, h=30-idler_space/2);
    
}

module bearing_holder()
{
    difference()
    {
        translate([-7.5,0,-m3_nut_h-10])
            cube([15,10,m3_nut_h*2+8+20]);
        union()
        {
            support_cones();
            bearing();
            translate([0,0,8])
                rotate([180,0,0])
                    bearing();
            translate([0,0,-m3_nut_h])
                nut();
            translate([0,0,8])
                nut();
        }
    }
}

bearing_holder();

