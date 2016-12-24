include <configuration.scad>;

height=5;
$fn=50;

difference()
{
    cube([20,3,50]);
    translate([10,height,10])
        rotate([90,0,0])
            cylinder(h=height+2,r=1.5);
    translate([10,height,40])
        rotate([90,0,0])
            cylinder(h=height+2,r=1.5);
    translate([10,height,25])
        rotate([90,0,0])
        {
            cylinder(h=height+2,r=4);
            cylinder(h=height-1,r=5.5);
        }
    translate([19,2.5,31.2])
        rotate([90,0,180])
            linear_extrude(1)
                text("FAN", size=6.5, font="Orbitron:style=Bold");
}