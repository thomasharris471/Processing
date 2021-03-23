//your differential equation is y' = f(t,y), where f is the function below

float f(float t, float y) {
  return y*y-4;
}

float ode2(float t, float y) {
  return -4*(y+2);
}

boolean displayO = true;
//boolean displayO = false;


float xScale = 10;

float deltaT = .001;

float numberOfParticles = 50;
