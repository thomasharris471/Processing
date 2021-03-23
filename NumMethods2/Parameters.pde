  double x0 = 1;
  double y0 = 2;
  double h = .001;

  double[] xRange = {-1, 3};
  double[] yRange = {-1, 3};
  
 
  
  
  //differential equation is y' = f(x,y)
  double f(double x, double y) {
    return 1-x*y; 
  }  
  
  double euler(double x, double y) {
    return y + h*f(x,y);
  }
  
  
  
  
  
  double rungekutta(double x, double y) {
    double k1 = f(x, y);
    double k2 = f(x + h/2, y + h*k1/2);
    double k3 = f(x + h/2, y + h*k2/2);
    double k4 = f(x + h, y + h*k3);
    return y + h/6*(k1 + 2*k2 + 2*k3 + k4);
  } 
  
  double yExact(double x) {
    return Math.exp(-2*x); 
  }
  
  

  
 boolean showEuler = true;
 boolean showRunge = false;
 boolean showExact = false;
 boolean showError = false;
  
  
  color eulerColor = color(0, 124, 52);
  color rungeColor = color(255, 0, 0);
  color errorColor = color(0,0,255);
  color exactColor = color(0,0,0);
  
  float ellipsesize = 5;
  
  float tickHeight = 5;
  
    double exactstepsize = 0.000001;
