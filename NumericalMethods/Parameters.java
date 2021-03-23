public class Parameters {
  
  public static double x0 = .1;
  public static double y0 = .1;
  public static double h = .01;

  public static double[] xRange = {-5, 5};
  public static double[] yRange = {-5, 5};
  
  //differential equation is y' = f(x,y)
  public static double f(double x, double y) {
    return x; 
  }  
  
  public static int stepsPerFrame = 1;
  
  
}
