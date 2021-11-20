// Primitives in SCAD: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids

// sphere --> Kugel, werden wir zum Abrunden verwenden: sphere(d = 20);
// cylinder --> Kegel, cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);
// cube --> quader, cube(size = [x,y,z], center = true/false);

// Basisartikel auf Deutsch http://hhoegl.informatik.hs-augsburg.de/fablab/Artikel/ct.1217.172-174.openscad.pdf

$fn=100; //  Auflösung

height=35; 
BottomRadius=30;
TopRadius=35; // spexor wird mit 70mm Durchmesser auf Amazon angegeben
Thickness_Wall=3; // das wird als Wandstärke "aussen" drauf gerechnet

//einfacher Kegel
//cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true);

/*difference() {
    translate([0,0,0]) cylinder(h = height, r1 = BottomRadius+Thickness_Wall, r2 = TopRadius+Thickness_Wall, center = true);
    #translate([0,0,0]) cylinder(h = height+6, r1 = BottomRadius, r2 = TopRadius, center = true);
} // das funktioniert nicht denn cylinder lassen sich nicht so einfach per difference bearbeiten:

*/

// hier lernen wir: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects

//cone_outer(5 ,10 ,5 ,400);
 //#cone_mid(5 ,10 ,5 ,400);

//von hier geklaut:https://linuxhint.com/openscad_beginner_guide-2/ 

thickn = 3;
baser = 33;
topr = 38;
height = 25;
nasentiefe=3; // spezifiziert wie weit die "haltenase" oben reingreift
nasenhoehe=2;
halterung_x=height;
halterung_y=10;
halterung_aussparung=3;
halterung_loch_radius=2;

union() {
// The bottom cone
    difference() {
        cylinder(r1 = baser, r2 = topr, h = height);
        cylinder(r1 = baser-thickn, r2 = topr - thickn, h = height + thickn);
        translate([topr, 0, height/2])cube(size = [halterung_x,halterung_aussparung,height], center = true); 
        }
/* original code
// The top ball
    translate([0, 0, height])
     difference(){
       sphere(r = topr);
       sphere(r = topr -thickn);
       translate([0, 0, -topr])
            cube(size = topr*2, center = true);
     }*/
// hohler deckel
    translate([0, 0, height])
     difference(){
       //sphere(r = topr);
       //sphere(r = topr -thickn);
       //translate([0, 0, -topr])
            cylinder(h = nasenhoehe, r1 = topr, r2 = topr, center = true);
            cylinder(h = nasenhoehe, r1 = topr-nasentiefe-thickn, r2 = topr-nasentiefe-thickn, center = true);
         translate([topr, 0, height/4])cube(size = [halterung_x,halterung_aussparung,height], center = true); 
     }        

// Halterung
     #translate([topr+thickn+3, 0, height/2])
     difference(){
       //sphere(r = topr);
       //sphere(r = topr -thickn);
       //translate([0, 0, -topr])
         cube(size = [halterung_x,halterung_y,height], center = true);   
         cube(size = [halterung_x,halterung_aussparung,height], center = true);  
         //loch in halterung
         rotate([90, 0, 0]) translate([0, 0, 0])cylinder(h = halterung_y+100, r1 = halterung_loch_radius, r2 = halterung_loch_radius, center = true); 
         //halterung noch an den kegel anpassen
       translate([-topr-height/4, 0, -height/2])cylinder(r1 = baser, r2 = topr, h = height);  
         
     }        


     
}


 
 module cone_outer(height,radius1,radius2,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=radius1*fudge,r2=radius2*fudge,$fn=fn);}
 module cone_mid(height,radius1,radius2,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r1=radius1*fudge,r2=radius2*fudge,$fn=fn);}

/*difference() {
    translate([2.5,2.5,0]) roundedcube(107,43,5,4);
    translate([3.5,3.5,2]) roundedcube(105,41,5,4);
    translate([56,26,-5]) scale([1,1,1]) cylinder(h=20, d=17, center=true);
}*/


/*difference() {
    translate([-2.5,-2.5,0]) roundedcube(117,53,12,4);
    translate([-0.5,-0.5,2]) roundedcube(113,49,12,4);
    translate([56,26,-5]) scale([1,1,1]) cylinder(h=20, d=17, center=true);
}*/

module roundedcube(xx, yy, height, radius) {

difference(){

    cube([xx,yy,height]);

    difference(){
        translate([-.5,-.5,-.2])
        cube([radius+.5,radius+.5,height+.5]);

        translate([radius,radius,height/2])
        cylinder(height,radius,radius,true);
    }
    translate([xx,0,0])
    rotate(90)
    difference(){
        translate([-.5,-.5,-.2])
        cube([radius+.5,radius+.5,height+.5]);

        translate([radius,radius,height/2])
        cylinder(height,radius,radius,true);
    }

    translate([xx,yy,0])
    rotate(180)
    difference(){
        translate([-.5,-.5,-.2])
        cube([radius+.5,radius+.5,height+.5]);

        translate([radius,radius,height/2])
        cylinder(height,radius,radius,true);
    }

    translate([0,yy,0])
    rotate(270)
    difference(){
        translate([-.5,-.5,-.2])
        cube([radius+.5,radius+.5,height+.5]);

        translate([radius,radius,height/2])
        cylinder(height,radius,radius,true);
    }
}
}