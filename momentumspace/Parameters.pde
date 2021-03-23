
//rescale position by a number
String xString = "sqrt(k)x";
float xAxisValue() {
  return sqrt(k)*x(); 
}

//rescale velocity by a number
String yString = "sqrt(m)v";
float yAxisValue() {
  return sqrt(m)*v(); 
}

//region you see in the plot
final static float[] xRange = {-20, 20};
final static float[] yRange = {-20, 20};


// m y'' + b y' + k y = f(t)

float m = 3;
float b = 0;
float k = 6;

//external force
float f(float t) {
  return  0; 
}

// initial conditions

float initialDisplacement = 5;
float initialVelocity = 0;



float dt = 0.001;

int stepsPerFrame = 10;
