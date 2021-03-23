public class Heat {

  private double[][] u;
  private double[] meanCurvature;
  
  private double dxSquared;
  private double dt;
  
  private void updateBoundaries() {
    int xPoints = u[0].length;
    //u[0][0] = u[0][1];
    u[0][0] = 0;
    u[0][xPoints-1] = u[0][xPoints-2];
 //  u[0][xPoints-1] = 0;
  }
  
  public Heat(InitialConditions i) {
    this(i.dx*i.dx, i.dt, i.setupU(), i.setupInitialK());
  }
  
  public Heat(double dxSquared, double dt, double[][] u, double[] meanCurvature) {
    this.dxSquared = dxSquared;
    this.dt = dt;
    this.u = u;
    this.meanCurvature = meanCurvature;
  }
  
  public double[] getHeat() {
    return u[0]; 
  }
  
  public void update() {
    for (int j = 1; j < u[0].length-1; j++) {
      u[1][j] = uOfIPlusOneHeat(0,j); 
    }
    for (int j = 1; j < u[0].length-1; j++) {
      u[0][j] = u[1][j]; 
    }
    updateBoundaries();
  }
  

  
  private double uOfIPlusOneHeat(int i, int j) {
    return u[i][j] + dt*(meanCurvature[j] + uxx(i,j)); 
  }
  
  private double uxx(int i , int j) {
     return (u[i][j-1] - 2*u[i][j] + u[i][j+1])/dxSquared;
  }
  
  
}
