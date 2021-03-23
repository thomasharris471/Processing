public class Heat {
  
  
  private double[][][] u;
  private double[][] meanCurvature;
  
  private double dxSquared;
  private double dySquared;
  private double dt;
  
  public Heat(InitialConditions i) {
    this(i.setupInitialK(), i.dt, i.dx, i.dy); 
  }
  
  public Heat(double[][] mean, double dt, double dx, double dy) {
    dxSquared = Math.pow(dx, 2);
    dySquared = Math.pow(dy, 2);
    this.dt = dt;
    
    meanCurvature = mean;
    
    int xPoints = mean.length;
    int yPoints = mean[0].length;
    
    u = new double[3][xPoints][yPoints];
    for (int j = 0; j < u[1].length; j++) {
      for (int k = 0; k < u[1][j].length; k++) {
         u[0][j][k] = 0;
         u[1][j][k] = 0;
         u[2][j][k] = 0;
      }
    }
  }
  
  public double[][][] getHeat() {
    return  u;
  }
  
  public void update() {
    for (int j = 1; j < u[1].length-1; j++) {
      for (int k = 1; k < u[1][j].length-1; k++) {
        u[2][j][k] =  uOfIPlusOneHeat(1, j, k);
      }
    }
    cylinderCompute();
    for (int j = 1; j < u[1].length-1; j++) {
      for (int k = 1; k < u[1][j].length-1; k++) {
        u[1][j][k] =  u[2][j][k];
      }
    }
    cylinderUpdate();
  }
  
  private void cylinderCompute() {
    int yPoints = u[1][0].length;
    for (int j = 1; j < u[1].length-1; j++) {
      u[2][j][0] =  u[1][j][0] + dt*(uxx(1,j,0) + (u[1][j][yPoints-1] - 2*u[1][j][0] + u[1][j][1])/dySquared);
      u[2][j][yPoints-1] =  u[1][j][yPoints-1] + dt*(uxx(1,j,yPoints-1) + (u[1][j][yPoints-2] - 2*u[1][j][yPoints-1] + u[1][j][0])/dySquared);
    }
  }
  
  private void cylinderUpdate() {
    int yPoints = u[1][0].length;
     for (int j = 1; j < u[1].length-1; j++) {
      u[1][j][0] = u[2][j][0];
      u[1][j][yPoints-1] = u[2][j][yPoints-1];
    }
  }
  
  public double getCurvature(int j, int k) {
    if (j == 0 || j == u[1].length-1 || k == 0 || k == u[1][1].length-1) {
      return meanCurvature[j][k]; 
    } 
    return (uOfIPlusOneHeat(1,j,k) - u[1][j][k])/(-dt);
  }

  
  private double uOfIPlusOneHeat(int i, int j, int k) {
    return u[i][j][k] + dt*(meanCurvature[j][k] + (uxx(i,j,k) + uyy(i,j,k))); 
  }
  
  private double uxx(int i , int j, int k) {
     return (u[i][j-1][k] - 2*u[i][j][k] + u[i][j+1][k])/dxSquared;
  }
  
  private double uyy(int i , int j, int k) {
     return (u[i][j][k-1] - 2*u[i][j][k] + u[i][j][k+1])/dySquared;
  }
  
}
