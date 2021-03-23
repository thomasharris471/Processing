public class InitialConditions {

  private static double[] xRange = {-1,1};
  private static double[] yRange = {-1,1};
  
  public static double dx = 0.01;
  public static double dy = 0.01;
  public static double dt = 0.00001;
  
  public static int stepsPerFrame = 100;
  

  
  public double meanK(double x, double y) {
    return 2;
  }
  
  
  
  public double[][] setupInitialK() {
    int xPoints = (int)Math.ceil((xRange[1] - xRange[0])/dx) + 1;
    int yPoints = (int)Math.ceil((yRange[1] - yRange[0])/dy) + 1;
    double[][] u0 = new double[xPoints][yPoints];
    for (int j = 0; j < xPoints; j++) {
      for (int k = 0; k < yPoints; k++) {
         double x = (xRange[1] - xRange[0])/xPoints*j + xRange[0];
         double y = (yRange[1] - yRange[0])/yPoints*k + yRange[0];
         u0[j][k] = meanK(x, y);
      }
    }
    return u0;
  }  
  
  
}
