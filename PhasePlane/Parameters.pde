//this is the matrix in the equation x' = Ax
float[] mat = {(float)1, (float)2, (float)3, (float)2};

//lower number = more particles on screen, higher number = less particles
float gridDensity = 50;

//modify these to change color/opacity/size of particles
color strokeColor = color(255,255,255);
float strokeOpacity = 255;
float weightOfStroke = 1;



color backgroundColor = color(10,10,10);
float backgroundOpacity = 20;


color axisColor = color(162,24,170);
float axisOpacity = 30;

color eigenvectorColor = color(45,245,0);
float eigenvectorOpacity = 30;

//these control the starting speed and the rate of speed increase
float baseTimeStep = 0.002;
float basespeedIncrease = .0005;
