public class InitialConditions {
  

  
  private static double[] xRange = {0,2};
  private static double[] yRange = {0,2};
  
  public static double dx = 0.01;
  public static double dy = 0.01;
  public static double dt = 0.001;
  public static double c =1;

  public static double period = Math.sqrt(Math.pow((xRange[1] - xRange[0])/2,2)+ Math.pow((yRange[1] - yRange[0])/2,2))/c;
    
  public static double frequency = 10*Math.PI/period;
  
  public static int stepsPerFrame = 10;
  
  
  public double initialU(double x, double y) {
    //return qWave(x,y,-1000, 1, 1); //+ 3*Math.exp(-1000*((x-.8)*(x-.8)+(y-.2)*(y-.2)));
    //return Noise.noise(5*x, 5*y);
   // return -qWave(x, y, -1000, 1, 1);
 //   return Math.cos(2*Math.PI*x - y);
   //return 5*(qWave(x,y, -1000, 0, .6) +  qWave(x, y, -1000, 0, .4) + 0*qWave(x,y, -1000, .2, .5));
   // // if (-x + 2 - 0.01 < y && -x + 2 + 0.01 > y && .5 < x && x < 1.5) {
   //    return 1;
   //  } else {
   //    return 0;
   //  }
 //  return 10*obqWave(x,y,-1000,1,1, Math.PI, 1, 1);
 return 0;
  }
//return 0;

  
  public double intialUPrime(double x, double y) {
    //return 10*obqWave(x,y,-1000,1,1, Math.PI, 1, 1);
    return 0;
  }
  
  private double rotAndStetchX(double x, double y, double theta, double stretch) {
    return (x*Math.cos(theta) - y*Math.sin(theta))*stretch;
  }
  
  private double rotAndStetchY(double x, double y, double theta, double stretch) {
      return (y*Math.cos(theta) + x*Math.sin(theta))*stretch;
  }

private double obqWave(double x, double y, double size, double xPos, double yPos, double theta, double sx, double sy) {
    return Math.exp(size*(Math.pow(rotAndStetchX(x-xPos, y-yPos, theta, sx),2) + Math.pow(rotAndStetchY(x-xPos,y-yPos,theta,sy), 2)));
  }
  
  private double qWave(double x, double y, double size, double xPos, double yPos) {
    return Math.exp(size*((x - xPos)*(x - xPos) + (y - yPos)*(y - yPos)));
  }
  
  private double squareWave(double x, double y, double size, double xPos, double yPos) {
    return Math.exp(size*(Math.abs((x - xPos)) + Math.abs((y - yPos))));
  }
  
  
  
  
  
  
  
  
  
  
  public double[][] setupInitialWave() {
    int xPoints = (int)Math.ceil((xRange[1] - xRange[0])/dx) + 1;
    int yPoints = (int)Math.ceil((yRange[1] - yRange[0])/dy) + 1;
    double[][] u0 = new double[xPoints][yPoints];
    for (int j = 0; j < xPoints; j++) {
      for (int k = 0; k < yPoints; k++) {
         double x = (xRange[1] - xRange[0])/xPoints*j + xRange[0];
         double y = (yRange[1] - yRange[0])/yPoints*k + yRange[0];
         u0[j][k] = initialU(x, y);
      }
    }
    return u0;
  }
  
   public double[][] setupInitialSpeed() {
    int xPoints = (int)Math.ceil((xRange[1] - xRange[0])/dx) + 1;
    int yPoints = (int)Math.ceil((yRange[1] - yRange[0])/dy) + 1;
    double[][] u0 = new double[xPoints][yPoints];
    for (int j = 0; j < xPoints; j++) {
      for (int k = 0; k < yPoints; k++) {
         double x = (xRange[1] - xRange[0])/xPoints*j + xRange[0];
         double y = (yRange[1] - yRange[0])/yPoints*k + yRange[0];
         u0[j][k] = intialUPrime(x, y);
      }
    }
    return u0;
  }
  
}
