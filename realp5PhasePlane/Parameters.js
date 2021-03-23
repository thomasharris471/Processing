//this is the matrix in the equation x' = Ax
var mat = (1,2,3,2);

//lower number = more particles on screen, higher number = less particles
var gridDensity = 30;

//modify these to change color/opacity/createCanvas of particles
let strokeColor = color(255,255,255);
var strokeOpacity = 255;
var weightOfStroke = 1;



let backgroundColor = color(10,10,10);
var backgroundOpacity = 20;


let axisColor = color(162,24,170);
var axisOpacity = 30;

let eigenvectorColor = color(45,245,0);
var eigenvectorOpacity = 30;

//these control the starting speed and the rate of speed increase
var baseTimeStep = 0.002;
var basespeedIncrease = 0.0005;
