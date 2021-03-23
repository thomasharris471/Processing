float currentDisplacement;
float previousDisplacement;

float currentTime;


void updateSpring() {
    float denominator = b*dt + 2*m;
    float num1 = (-2*dt*dt*k+4*m)*currentDisplacement;
    float num2 = (b*dt - 2*m)*previousDisplacement;
    float num3 = 2*dt*dt*f(currentTime);
    previousDisplacement = currentDisplacement;
    currentDisplacement = (num1 + num2 + num3)/denominator;
    currentTime = currentTime + dt;
}

float computeVelocity() {
  return ( currentDisplacement - previousDisplacement)/dt;
}

float computeMomentum() {
  return m*computeVelocity();
}

float x() {
  return currentDisplacement; 
}

float v() {
  return computeVelocity();
}
