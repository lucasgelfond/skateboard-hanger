truckHolderDepth  = 10;
truckHolderWidth = 10;
truckHolderThick = 5;
truckHolderFlatLength = 40;
truckHolderDiagonalAngle1 = 360-15;
truckHolderDiagonalAngle2 = 360-60;
truckHolderDiagonal1Length = 40;
truckHolderDiagonal2Length = 40;
cutoff = 1;


//internal
yTranslateDiagonal2 = sin(180-truckHolderDiagonalAngle1) * -truckHolderDiagonal1Length;
xTranslateDiagonal2 = cos(180-truckHolderDiagonalAngle1) * truckHolderDiagonal1Length;

module truckHolderPiece(length, lengthCutoff, widthCutoff, thickCutoff) {
    cube([length+lengthCutoff, truckHolderWidth+widthCutoff, truckHolderThick+thickCutoff], center=true);
}

truckHolderPiece(truckHolderFlatLength,0,0,0);

/*
Just get this module to the center of a diagonal joint. It will do the rest. 

*/
module diagonalJoint(lastJointLength, angle, newLength, thickness) {
    difference() {
        translate([lastJointLength/2,0,0]) {
            rotate([0,angle,0]) {
                difference() {
                    truckHolderPiece(newLength*2,0,0,0);
                    translate([(newLength+thickness*2)/-2, 0,0]) truckHolderPiece(newLength-thickness*2,0,cutoff,cutoff);
                }
            }
        }
    translate([0,cutoff,truckHolderThick*-2.5]) scale([1,1+cutoff,4]) truckHolderPiece(newLength*2, 0,0,0);
    }
}


diagonalJoint(truckHolderFlatLength, truckHolderDiagonalAngle1, truckHolderDiagonal1Length, truckHolderThick);
translate([-xTranslateDiagonal2, 0, yTranslateDiagonal2]) {
    diagonalJoint(truckHolderDiagonal1Length, truckHolderDiagonalAngle2, truckHolderDiagonal2Length, truckHolderThick);
}
