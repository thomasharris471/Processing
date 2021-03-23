public class RungeKutta extends Algorithm {

  private static int red = 255;
  private static int green = 0;
  private static int blue = 0;
  
  
  public RungeKutta(double y0) {
    super(y0, red, green, blue);
  }
  
  public double nextY(double x, double y, double h) {
    double k1 = Parameters.f(x, y);
    double k2 = Parameters.f(x + h/2, y + h*k1/2);
    double k3 = Parameters.f(x + h/2, y + h*k2/2);
    double k4 = Parameters.f(x + h, y + h*k3);
    return y + h/6*(k1 + 2*k2 + 2*k3 + k4);
  } 
}
  
