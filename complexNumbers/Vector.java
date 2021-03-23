public class Vector {
 
  private double r;
  private double theta;
  
  public Vector(double x, double y) {
    r = Math.sqrt(x*x + y*y);
    theta = getTheta(x,y);
  }
  
  
  public void rotate(double radians) {
     theta = theta + radians;
  }
  
  public void scale(double factor) {
    r = r*factor;
  }
  
  public double getX() {
    return r*Math.cos(theta); 
  }
  
  public double getY() {
    return r*Math.sin(theta); 
  }
  
  public double getR() {
    return r; 
  }
  
  public double getTheta() {
    return theta;
  }
  
  private double getTheta(double x, double y) {
   if (x >= 0) {
      return Math.atan(y/x); 
    } else {
      return Math.atan(y/x) + Math.PI; 
    }
  }
}
