public class Algorithm {
  
  private int red;
  private int green;
  private int blue;
  
  private double yVal;

  private static double x;

  public Algorithm(double y0, int red, int green, int blue) {
    this.yVal = y0;
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  

  public double nextY(double x, double y, double h) {
    return 0;
  }
  
   public int getRed() {
    return red; 
  }
  
  public int getGreen() {
    return green; 
  }
  
  public int getBlue() {
    return blue; 
  }

  public double y() {
    return yVal; 
  }
  
  public void setY(double y) {
    yVal = y; 
  }
  
  public static double x() {
    return x; 
  }
  
  public static void setX(double nux) {
    x = nux; 
  }
  
  public static double nextX(double h) {
    return x + h;
  }
  
}
