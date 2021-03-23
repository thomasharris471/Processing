
//rescale position by a number
String xString = "";
float xAxisValue() {
  return x(); 
}

//rescale velocity by a number
String yString = "";
float yAxisValue() {
  return v(); 
}

//region you see in the plot
final static float[] xRange = {-10, 10};
final static float[] yRange = {-30, 30};


//  y'' + a y' + b y  + c y^3 = f(t)

float a = 0.05;
float b = 0;
float c = 1;

//external force
float f(float t) {
  return  8*cos(t); 
}

// initial conditions

float initialDisplacement = 2;
float initialVelocity = 2.9;



float dt = 2*PI/1000;

int stepsPerFrame = 1000;
