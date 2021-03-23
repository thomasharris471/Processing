public class GradientVectorField {
  
  double dx;
  double dy;
  double dt;
  double x;
  double y;
  
  double sign;
  
  
  public GradientVectorField(double dx, double dy, double dt, double x, double y) {
    this.dx = dx;
    this.dy = dy;
    this.dt = dt;
    this.x = x;
    this.y = y;
    sign = 1;
  }
  
  public void flipSign() {
    sign = -sign; 
  }
  
  public void jiggleball() {
    x = x + Math.random()*dx/2 - dx;
    y = y + Math.random()*dy/2 - dy;
  }
  
  public void updatePosition() {
    double u00 = InitialConditions.u(x,y);
    double u01 = InitialConditions.u(x,y+dy);
    double u10 = InitialConditions.u(x+dx,y);
    double u11 = InitialConditions.u(x+dx,y+dy);
    
    double gradX = (u10 - u00)/dx;
    double gradY = (u01 - u00)/dy;
    
    x = x - sign*gradX*dt;
    y = y - sign*gradY*dt;
  }
  
  public void move(double x, double y) {
    this.x = x;
    this.y = y;
  }
  
  public double getX() {
    return x; 
  }
  
  public double getY() {
    return y; 
  }
  
  public double getgradX(double x, double y) {
    double u00 = InitialConditions.u(x,y);
    double u01 = InitialConditions.u(x,y+dy);
    double u10 = InitialConditions.u(x+dx,y);
    double u11 = InitialConditions.u(x+dx,y+dy);
    
    double gradX = (u10 - u00)/dx;
    double gradY = (u01 - u00)/dy;
    return gradX;
  }
  
   public double getgradY(double x, double y) {
    double u00 = InitialConditions.u(x,y);
    double u01 = InitialConditions.u(x,y+dy);
    double u10 = InitialConditions.u(x+dx,y);
    double u11 = InitialConditions.u(x+dx,y+dy);
    
    double gradX = (u10 - u00)/dx;
    double gradY = (u01 - u00)/dy;
    return gradY;
  }
  
}
