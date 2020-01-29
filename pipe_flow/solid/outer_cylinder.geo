// you can modify the values of r = radius of inner cylinder, R = radius of outer cylinder , n1 = mesh density along radial direction, n2 = mesh density along theta direction, n3 = mesh density along Z direction
r = 0.05;
R = 0.055;
len = 0.5;
n1 = 3;
n2 = 10;
n3 = 50;

// modify things below if you know what are you doing

Point(1) = {0, 0, 0, 1.0};
Point(2) = {r, 0, 0, 1.0};
Point(3) = {R, 0, 0, 1.0};
Point(4) = {0.0, r, 0, 1.0};
Point(5) = {0.0, R, 0, 1.0};
Point(6) = {-r, 0.0, 0, 1.0};
Point(7) = {-R, 0.0, 0, 1.0};
Point(8) = {0, -r, 0, 1.0};
Point(9) = {0, -R, 0, 1.0};

Circle(10) = {2, 1, 4};
Circle(11) = {4, 1, 6};
Circle(12) = {6, 1, 8};
Circle(13) = {8, 1, 2};
Circle(14) = {3, 1, 5};
Circle(15) = {5, 1, 7};
Circle(16) = {7, 1, 9};
Circle(17) = {9, 1, 3};

Line(18) = {2, 3};
Line(19) = {4, 5};
Line(20) = {6, 7};
Line(21) = {8, 9};

Transfinite Line{18,19,20,21} = n1;
Transfinite Line{10,11,12,13,14,15,16,17} = n2;

Line Loop(22) = {-18, 10, 19, -14};
Ruled Surface(22) = {22};
Transfinite Surface(22) = {2,3,5,4};
Recombine Surface(22);

Line Loop(23) = {-19, 11, 20, -15};
Ruled Surface(23) = {23};
Transfinite Surface(23) = {4,5,7,6};
Recombine Surface(23);

Line Loop(24) = {-20, 12, 21, -16};
Ruled Surface(24) = {24};
Transfinite Surface(24) = {6,7,9,8};
Recombine Surface(24);

Line Loop(25) = {-21, 13, 18, -17};
Ruled Surface(25) = {25};
Transfinite Surface(25) = {8,9,3,2};
Recombine Surface(25);



newEntities[]=
Extrude {0, 0, len} {
  Surface{25, 22, 23, 24};
  Layers{n3};
  Recombine;
};

Transfinite Volume{1} = {2, 3, 9, 8, 16, 20, 10, 11};
Recombine Volume(1);
Transfinite Volume{2} = {4, 5, 3, 2, 27, 31, 20, 16};
Recombine Volume(2);
Transfinite Volume{3} = {6, 7, 5, 4, 38, 42, 31, 27};
Recombine Volume(3);
Transfinite Volume{4} = {8, 9, 7, 6, 11, 10, 42, 38};
Recombine Volume(4);


Mesh.ElementOrder=2;
Mesh.Optimize=1;
Mesh.SecondOrderIncomplete=1;
//Mesh.RemeshParametrization = 7;

// Display control
//Mesh.SurfaceEdges = 1;
Mesh.SurfaceFaces = 1;
Mesh.VolumeEdges = 0;
//Mesh.VolumeFaces = 0;

Mesh 3;

Physical Surface("outlet") = {113, 47, 69, 91};
Physical Surface("inlet") = {22, 25, 24, 23};
Physical Surface("wall") = {68, 90, 112, 46};
Physical Surface("interface") = {38, 60, 82, 104};

Physical Volume("solid") = {1, 2, 3, 4};

Mesh.SaveGroupsOfNodes = 1;
// Mesh.CharacteristicLengthMax = 5;
//Save "outer.msh";
Save "outer.inp";

