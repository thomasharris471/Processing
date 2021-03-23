double theta;
double previousTheta;

double currentTime;

double acceleration() {
  return -friction*velocity()*Math.pow(mass*ironDensity, -0.33) - gravity/length*theta;
}

double velocity() {
  return (theta - previousTheta)/dt;
}

void updateValue() {
  double thetaHolder = acceleration()*dt*dt + 2*theta - previousTheta;
  previousTheta = theta;
  theta = thetaHolder;
}

void initializePendulum() {
  theta = theta0;
  previousTheta = theta - thetaPrime0*dt;
}
