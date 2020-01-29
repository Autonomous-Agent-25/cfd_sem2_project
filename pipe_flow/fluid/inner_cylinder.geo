// you can modify the values of r = radius of inner square, R = radius of outer cylinder , n1 = mesh density along radial direction, n2 = mesh density along theta direction, n3 = mesh density along Z direction
R = 0.05;
r = 0.02;
len = 0.5;
n1 = 10;
n2 = 10;
n3 = 50;

// modify things below if you know what are you doing

Point(1) = {0, 0, 0, 1.0};
Point(2) = {R, 0, 0, 1.0};
Point(3) = {r, 0, 0, 1.0};
Point(4) = {0.0, R, 0, 1.0};
Point(5) = {0.0, r, 0, 1.0};
Point(6) = {-R, 0.0, 0, 1.0};
Point(7) = {-r, 0.0, 0, 1.0};
Point(8) = {0, -R, 0, 1.0};
Point(9) = {0, -r, 0, 1.0};

Circle(10) = {2, 1, 4};
Circle(11) = {4, 1, 6};
Circle(12) = {6, 1, 8};
Circle(13) = {8, 1, 2};

//Circle(14) = {3, 1, 5};
//Circle(15) = {5, 1, 7};
//Circle(16) = {7, 1, 9};
//Circle(17) = {9, 1, 3};

Line(14) = {3, 5};
Line(15) = {5, 7};
Line(16) = {7, 9};
Line(17) = {9, 3};

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

Line Loop(26) = {14,15,16,17};
Ruled Surface(26) = {26};
Transfinite Surface(26) = {3,5,7,9};
Recombine Surface(26);

newEntities[]=
Extrude {0, 0, len} {
  Surface{25, 22, 23, 24, 26};
  Layers{n3};
  Recombine;
};

Transfinite Volume{1} = {2, 3, 9, 8, 16, 20, 10, 11};
Transfinite Volume{2} = {4, 5, 3, 2, 27, 31, 20, 16};
Transfinite Volume{3} = {6, 7, 5, 4, 38, 42, 31, 27};
Transfinite Volume{4} = {8, 9, 7, 6, 11, 10, 42, 38};
Transfinite Volume{5} = {9, 7, 5, 3, 10, 42, 31, 20};

Physical Surface("inlet") = {24, 23, 22, 25, 26};
//+
Physical Surface("outlet") = {114, 48, 70, 92, 136};
//+
Physical Surface("interface") = {39, 61, 83, 105};
//+
Physical Volume("fluid") = {1, 2, 3, 4, 5};

Mesh.ElementOrder=1;
Mesh.Optimize=1;
//Mesh.RemeshParametrization = 7;

// Display control
//Mesh.SurfaceEdges = 1;
Mesh.SurfaceFaces = 1;
Mesh.VolumeEdges = 0;
//Mesh.VolumeFaces = 0;

Mesh 3;

//Mesh.SaveGroupsOfNodes = 1;
// Mesh.CharacteristicLengthMax = 5;
Save "inner.msh";
//+

//+

