// Wheelchair Handle Deterrent
// Version 1.2
// Fully parameterized model for wheelchair handle spikes.
// You attach this to the handles of a wheelchair to prevent people from grabbing them without consent/permission.

// Wheelchair Handle Deterrent © 2024-04-29 by Joe Shields is licensed under CC BY-SA 4.0. 
// To view a copy of this license, visit https://creativecommons.org/licenses/by-sa/4.0/
// This means you can distribute, remix, adapt, and build upon the material in any medium or format, 
// even for commercial purposes, provided the following conditions:
// You must provide attribution to the creator(s).
// You must license any derivative works under this same license.

/*[technical stuff]*/
// factor for unit conversion
scaleFactor=25.4; // [25.4:input inches and output mm (RECOMMENDED), 2.54:input inches and output cm, 1:input units same as output units, 0.39370078740157480315:input cm output inches, 0.03937007874015748031:input mm output inches (NOT RECOMMENDED)]
// minimum facet angle for circles (not influenced by scaleFactor). Lower this to eliminate the "lowpoly" appearance of the ring (increases STL file size).
fa_input=6; // [1:12]
$fa=fa_input;
// minimum facet size for circles (not influenced by scaleFactor). Lower this to eliminate the "lowpoly" appearance of the ring (increases STL file size).
fs_input=1; // [0.01:0.01:2]
$fs=fs_input;

/*[ring]*/
// inner diameter of the ring. Make this a little smaller (about 0.04 inches) than the OD of the handle for a friction fit.
ringID_input=0.875; // .001
ringID=ringID_input*scaleFactor;

// wall thickness of the ring
ringThickness_input=0.188; // .001
ringThickness=ringThickness_input*scaleFactor;
ringOD=ringID+ringThickness*2;

// how much space the ring will occupy on the handle
ringWidth_input=0.75; // .001
ringWidth=ringWidth_input*scaleFactor;

/*[spikes]*/
// width of the spikes (circumferential direction). Increase this for stronger, blunter spikes.
spikeWidth_input=0.25; // .001
spikeWidth=spikeWidth_input*scaleFactor;

// how far the spikes stick out from the ring
spikeLength_input=1; // .001
spikeLength=spikeLength_input*scaleFactor;

// height of the spikes (axial direction). This should be less than the ring width. Increase this for stronger, blunter spikes.
spikeHeight_input=0.375; // .001
spikeHeight=spikeHeight_input*scaleFactor;

// number of spikes. If you increase this high enough, you'll get a disk. If you do this, it's recommended you opt for the bolt tab and do not undersize ringID.
nSpikes=7; // [1:36]

// circumferential position where the spikes start. This must be less than spikeAngleEnd.
spikeAngleStart=-45; // [-90:270]
// circumferential positoin where the spikes end. This must be greater than spikeAngleStart.
spikeAngleEnd=225; // [-90:270]
spikeStep=(spikeAngleEnd-spikeAngleStart)/(nSpikes-1);

/*[bolt tab]*/
// This adds a tab with a hole, allowing you to tighten the ring with a screw and nut. The length of bolt/screw should be at least 2*tabThickness+slitSize plus the thickness of the nut and any washers you use. (You should use washers.)
hasTab=true;

// how far the tab sticks out from the ring.
tabLength_input=0.375; // .001
tabLength=tabLength_input*scaleFactor; // [0, ringWidth/2]

// wall thickness of the tab. This should be at least as large as ringThickness.
tabThickness_input=0.188; // .001
tabThickness=tabThickness_input*scaleFactor;

// size of the slit in the ring. Making this larger (and possibly also increasing tabLength) can help the ring grip better.
slitSize_input=0.125; // .001
slitSize=slitSize_input*scaleFactor;
slitLength=(ringID/2+ringThickness+tabLength+spikeLength)*1.1;

// size of the hole for the bolt/screw. 0.13 inches is sufficient for #4 or M3 screws. Search online for "clearance hole chart" if you want to size this for a different fastener.
boltHoleID_input=0.13; // .001
boltHoleID=boltHoleID_input*scaleFactor;

// how far along the tab (radial direction) the hole is from the ring
holePositionFactorR=0.5; // [0:0.1:1]
holePositionR=tabLength*holePositionFactorR;

// how far along the tab (axial direction) the hole is from the chamfered corner of the tab
holePositionFactorZ=0.7; // [0:0.1:1]
holePositionZ=ringWidth*holePositionFactorZ;
jointWidth=tabThickness*2+slitSize;


module spikeArray(){
    color("red", alpha = 0.5)
    union(){
    for (angle=[spikeAngleStart:spikeStep:spikeAngleEnd])
    {
        rotate([0,0,angle])
            translate([0,-ringID/2,-ringWidth/2])
                rotate([90,0,-90])
                    linear_extrude(spikeWidth, center=true)
                        polygon(points=[ [0,0], [spikeLength+ringThickness,0], [0,spikeHeight] ]);
    }
    }
}

module tab() // adds the bolt tab
{
    difference()
    {
        // body of the tab
        translate([-ringID/2,0,0])
            rotate([90,0,180])
                translate([0,-ringWidth/2,-(jointWidth)/2])
                    linear_extrude(jointWidth)
                        polygon(points=[[0,0], [0,ringWidth], [tabLength+ringThickness,ringWidth], [tabLength+ringThickness, tabThickness], [tabLength+ringThickness-tabThickness,0]]);
        // bolt hole
        translate([-(ringOD/2+holePositionR),0,-(ringWidth/2-holePositionZ)])
            rotate([90,0,0])
                cylinder(h=jointWidth*1.1, r=boltHoleID/2, center=true);
    }
}

color("blue", alpha = 0.5)
difference(){
    union(){
        cylinder(h=ringWidth, r=ringID/2+ringThickness, center=true);
        spikeArray();
        if (hasTab) tab();
    }
    translate([-slitLength/2,0,0])
        cube([slitLength,slitSize,ringWidth*1.1], center=true);
    cylinder(h=ringWidth+1, r=ringID/2, center=true);

}


