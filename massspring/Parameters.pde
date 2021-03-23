// m y'' + b y' + k y = f(t)

float m = 3;
float b = 6;
float k = 3;

float stepsPerFrame = 5;

float omega = 0;

//external force
float f(float t) {
//  return 500*cos(10*t);
  return 0; 
}

// initial conditions

float initialDisplacement = 200;
float initialVelocity = 0;
