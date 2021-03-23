import java.lang.Math;

double myPow(double x, int n) {
  double base = 1;
  for (int i = 1; i <= n; i++) {
    base = base*x;
  }
  return base;
}

function taylorSeries(final function f, final double x0, final int order, final double dx) {
   return new function() {
    @Override
    public double apply(double x) {
      double val = 0;
      for (int i = 0; i <= order; i++) {
        val = val + derivative(f, dx, i).apply(x0)*Math.pow(x-x0,i)/factorial(i);  
      }
      return val; 
    }
  };
  
}


function derivative(final function f, final double dx, final int n) {
  return new function() {
    @Override
    public double apply(double x) {
      double val = 0;
      double p = Math.pow(dx,n);
      for (int i = 0; i <= n; i++) {
          double a = f.apply(x + ((double)n-i)*dx)*choose(n,i);
          double b =  Math.pow(-1,i);
          val = val + b*a;
      }
      return val/p;
    }
  };
}
 

function derivative(final function f, final double dx) {
  return new function() {
    @Override
    public double apply(double x) {
      return (f.apply(x+dx/2) - f.apply(x-dx/2))/dx; 
    }
  };
}


public interface function {
  public double apply(double x);
}

int factorial(int n) {
  if (n <= 1) {
     return 1;
  } else {
    return n*factorial(n-1); 
  }
}

double choose(int n, int i) {
  return (double) factorial(n)/(factorial(n-i)*factorial(i));
}
