public class Wave {
  
  private int xPoints;

  
  private double dx;


  private double dt;
  
  private double time;
  
  private double c = 1;

  private double[][] u;
  
  
  public Wave(InitialConditions ic) {
    this(ic.setupInitialWave() , ic.setupInitialSpeed(), ic.dt(), ic.dx(), ic.xPoints);
  }
  
  public void update() {
     updateInteriorWave();
      updateBoundary();
  }
  
  public double[][] getWave() {
     return u;
  }
  
  
  
  //time invariant wave
  public Wave(double[] u0, double[] uPrime0, double dt, double dx, int xPoints) {
    this.xPoints = xPoints;
    this.dt = dt;
    this.dx = dx;
    u = new double[3][xPoints];
    for (int j = 0; j < xPoints; j++) {
        u[0][j] = u0[j];
    }
    for (int j = 1; j < xPoints - 1; j++) {
        u[1][j] = u[0][j] + dt*uPrime0[j] + Math.pow(dt,2)/2.0*utt(0, j);
    }
    
    u[1][0] = u[0][0];
    u[1][xPoints - 1] = u[0][xPoints-1];
    
    
    
  }
  

  private void updateBoundary() {
    u[1][0] = 0.99*u[1][1];
    u[1][xPoints - 1] = 0.99*u[1][xPoints-2];
  }
  
  
  private void updateInteriorWave() {
    for (int j = 1; j < xPoints - 1; j++) {
         u[2][j] = uOfIPlusOne(1, j);
    }
    for (int j = 1; j < xPoints - 1; j++) {
         u[0][j] = u[1][j];
         u[1][j] = u[2][j];
    }
  }
  
  private double u(int i, int j) {
    return u[i][j]; 
  }
  
  private double uOfIPlusOne(int i, int j) {
  //  return -u(i-1, j, k) + 2*u(i, j, k) + Math.pow(dt, 2)*utt(i, j, k); 
  return -u(i-1, j) + 2*u(i, j) + dt*dt*utt(i, j) ; 
  }
  
  private double utt(int i, int j) {
     return Math.pow(c, 2)*(uxx(i,j));
  }
  
  private double uxx(int i , int j) {
//     return (u[i][j-1][k] - 2*u[i][j][k] + u[i][j+1][k])/Math.pow(dx,2);
return (u[i][j-1] - 2*u[i][j] + u[i][j+1])/(dx*dx);
  }

}
