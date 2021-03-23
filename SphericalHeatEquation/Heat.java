public class Heat {
  
  private int xPoints;
  private int yPoints;
  
  private double[][][] u;
  
  private double[][] kurv;
  
  private double cdt;
  
  private double dxSquared;
  private double dySquared;
  
  
  
  
  
  
  public double[][][] getWave() {
     return u;
  }
  
  public void update() {
    computeNextWave();
    for (int j = 1; j < u[1].length-1; j++) {
      for (int k = 0; j < u[1][j].length-1; k++) {
        u[1][j][k] = u[2][j][k]; 
      }
    }
  }
  
  public Heat(InitialConditions ic) {
    this(ic.setupInitialWave() , ic.setupInitialKurv(), ic.dt,  ic.c, ic.dx, ic.dy);
  }
  
  
  public Heat(double[][] u0, double[][] kurv, double dt, double c, double dx, double dy) {
    dxSquared = Math.pow(dx, 2);
    dySquared = Math.pow(dy, 2);
    cdt = c*dt;
    xPoints = u0.length;
    yPoints = u0[0].length;
    
    u = new double[3][xPoints][yPoints];
    for (int j = 0; j < xPoints; j++) {
      for (int k = 0;  k < yPoints; k++) {
        u[1][j][k] = u0[j][k];
        
      }
    }
  }
  
  
  private void computeNextWave() {
    for (int j = 1; j < u[1].length-1; j++) {
      for (int k = 1; k < u[1][j].length-1; k++) {
        u[2][j][k] = uOfIPlusOneHeat(1, j, k);
      }
    }
    for (int j = 1; j < u[1].length-1; j++) {
      u[2][j][0] =  u[1][j][0] + cdt*(uxx(1,j,0) + (u[1][j][yPoints-1] - 2*u[1][j][0] + u[1][j][1])/dySquared);
    }
  }
  
  private double uOfIPlusOneHeat(int i, int j, int k) {
    return u[i][j][k] + cdt*(uxx(i,j,k) + uyy(i,j,k) + kurv[j][k]); 
  }
  
  private double uxx(int i , int j, int k) {
     return (u[i][j-1][k] - 2*u[i][j][k] + u[i][j+1][k])/dxSquared;
  }
  
  private double uyy(int i , int j, int k) {
     return (u[i][j][k-1] - 2*u[i][j][k] + u[i][j][k+1])/dySquared;
  }
}
