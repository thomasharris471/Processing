public class Euler extends Algorithm {

  private static int red = 0;
  private static int green = 124;
  private static int blue = 52;
  
  
  public Euler(double y0) {
    super(y0, red, green, blue);
  }
  
  public double nextY(double x, double y, double h) {
    return y + h*Parameters.f(x,y);
  } 
  
}
