public class InitialConditions {
  

  
  public static double[] xRange = {-10,10};
  public static double[] yRange = {-10,10};
  public static double[] uRange = {-.5,.5};
  
  public static int xPlotPoints = 200;
  public static int yPlotPoints = 200;
  
  public static double dx = (xRange[1] - xRange[0])/xPlotPoints;
  public static double dy = (yRange[1] - yRange[0])/yPlotPoints;
  public static double dt = .5;

  
  public static int stepsPerFrame = 5;
  
  
  public static double u(double x, double y) {
    return  Noise.noise(.2*x+1000, .2*y+3000);
  }

  public static int getXPoints() {
    return (int)Math.ceil((xRange[1] - xRange[0])/dx) + 1;
  }
  
  public static int getYPoints() {
    return (int)Math.ceil((yRange[1] - yRange[0])/dy) + 1;
  }
  
  

}
