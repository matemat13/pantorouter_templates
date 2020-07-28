echo(version=version());
$fn=50;

/** USER-DEFINED PARAMETERS **/
di = 8; // diameter of the pin for the inner milling
do = 12; // diameter of the pin for the outer milling
D = 10; // tool diameter
aD = 2; // width of the knob will be D+aD
l = 50; // length of the knob
h = 20; // height of the milling template
hf = 1; // height of the inner floor


/** CALCULATED PARAMETERS **/
ri = di/2; // internal milling pin radius
ro = do/2; // external milling pin radius
R = D/2; // tool radius
w = D + aD; // width of the knob

wi = 2*w - 2*D + di; // width of the inner guide
li = 2*l - 2*D + di; // length of the inner guide

wo = 2*w + 2*D - do; // width of the outer guide
lo = 2*l + 2*D - do; // length of the outer guide

/** MODULES **/
module inner_guide()
{
    offset(r=-ro) offset(r = -D+ri) // inner and outer fillet
        union() // the two rectangles, creating the basis of the inner guide
        {
            square([2*w+do, 2*l+do], center = true);
            rotate(90) square([2*w+do, 2*l+do], center = true);
        };
}

module outer_guide()
{
    offset(r=ro) offset(r = +D-ro) // inner and outer fillet
        union() // the two rectangles, creating the basis of the inner guide
        {
            square([2*w-do, 2*l-do], center = true);
            rotate(90) square([2*w-do, 2*l-do], center = true);
        };
}


/** THE OBJECT **/
difference()
{
    //linear_extrude(height = h, scale = 0.9) outer_guide();
    //translate([0, 0, hf]) linear_extrude(height = h, scale = 0.9) inner_guide();
    
    offset(r=-R+ro/2) scale([0.5,0.5]) outer_guide();
    offset(r=+R-ri/2) scale([0.5,0.5]) inner_guide();
}