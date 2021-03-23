double theta0 = PI/10;
double thetaPrime0 = 4;

//kg
double mass = 6;
double friction = 0;

//meters
double length = 10;

//meters/second^2
double gravity = 10;


double zoom = 1;












double ironDensity = 7874;

double arcProportion = .3;

double dt = 0.001/(2*PI);
int stepsPerFrame = 100;

double[] xAxis = {-3*length/zoom, 3*length/zoom};
double[] yAxis = {-3*length/zoom, 3*length/zoom};


color white = color(255,255,255);
color green = color(45,245,0);
color purple = color(162,24,170);
color backgroundColor = color(10,10,10);

color rodColor =  white;
color massColor = white;
color arcColor =  green;
