public class InitialConditions {

  public static double[] xRange = {-1,1};
  
  public static double dx = 0.01;

  public static double dt = 0.00001;
  
  public static int stepsPerFrame = 1000;
  
  public double meanK(double x) {
    return 2;
  }
  
  public double[][] setupU() {
    int xPoints = (int)Math.ceil((xRange[1] - xRange[0])/dx) + 1;
    double[][] u0 = new double[2][xPoints];
    for (int j = 0; j < xPoints; j++) {
         u0[0][j] = 0;
         u0[1][j] = 0;
    }
    return u0;
  }
  
  public double[] setupInitialK() {
    int xPoints = (int)Math.ceil((xRange[1] - xRange[0])/dx) + 1;
    double[] u0 = new double[xPoints];
    for (int j = 0; j < xPoints; j++) {
         double x = (xRange[1] - xRange[0])/xPoints*j + xRange[0];
         u0[j] = meanK(x);
    }
    return u0;
  }  
  
}
