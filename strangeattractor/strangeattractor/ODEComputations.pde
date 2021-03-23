float currentDisplacement;
float previousDisplacement;

float currentVelocity;
float previousVelocity;

float currentTime;


void updateSpring() {
    float num1 = 2*currentDisplacement - previousDisplacement;
    float num2 = -dt*(a*currentDisplacement + b*dt*currentDisplacement + c*dt*pow(currentDisplacement,3) - a*previousDisplacement);
    float num3 = pow(dt,2)*f(currentTime);
    previousDisplacement = currentDisplacement;
    currentDisplacement = (num1 + num2 + num3);
    previousVelocity = currentVelocity;
    currentVelocity = (currentDisplacement - previousDisplacement)/dt;
    currentTime = currentTime + dt;
}

float computeVelocity() {
  return ( currentDisplacement - previousDisplacement)/dt;
}

float computeMomentum() {
  return computeVelocity();
}

float x() {
  return currentDisplacement; 
}

float px() {
  return previousDisplacement; 
}

float v() {
  return computeVelocity();
}

float pv() {
  return previousVelocity; 
}
