double theta;
double omega;

double previousTheta;

double currentTime;

double acceleration() {
  return -friction*velocity()*Math.pow(mass*ironDensity, -0.33) - gravity/length*Math.sin(theta);
}

double velocity() {
  return (theta - previousTheta)/dt;
}

void updateValue() {
//  double thetaHolder = acceleration()*dt*dt + 2*theta - previousTheta;
//  previousTheta = theta;
//  theta = thetaHolder;
  rungeKutta();
}

void initializePendulum() {
 // theta = theta0;
 // previousTheta = theta - omega0*dt;
 theta = theta0;
 omega = omega0;
}

//thetaPrime
double f1(double theta, double omega) {
   return omega;
}

//omegaPrime
double f2(double theta, double omega) {
  return -friction/mass*omega - gravity/length*Math.sin(theta); 
}

void rungeKutta() {
  double k11 = dt*f1(theta, omega);
  double k21 = dt*f2(theta, omega);
  
  double k12 = dt*f1(theta + 0.5*k11, omega + 0.5*k21);
  double k22 = dt*f2(theta + 0.5*k11, omega + 0.5*k21);
  
  double k13 = dt*f1(theta + 0.5*k12, omega + 0.5*k22);
  double k23 = dt*f2(theta + 0.5*k12, omega + 0.5*k22);
  
  double k14 = dt*f1(theta + k13, omega + k23);
  double k24 = dt*f2(theta + k13, omega + k23);
  
  theta = theta + (k11 + 2*k12 + 2*k13 + k14)/6.0;
  omega = omega + (k21 + 2*k22 + 2*k23 + k24)/6.0;
}
