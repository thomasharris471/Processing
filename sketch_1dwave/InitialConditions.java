public class InitialConditions {
  
  public double minusX = 0;
  public double plusX = 1;
  
  public static int stepsPerFrame = 10;
  
  public double dt = 0.001;
  
  public static int xPoints = 600;
  
  
  public static double heightMax = 1;
  public static double heightMin = 0;
  
  public double initialU(double x) {

    return Math.exp(-400*(x-.3)*(x-.3));
    //int omega = 10;
  //  return Math.sin(5*2*Math.PI*x) + Math.cos(3*2*Math.PI*x)-1;
    //int omega = 4;
    //return Noise.noise(omega*x);
  }
  
  public double intialUPrime(double x) {
    return 0; 
  }
  
  
  
  
  
  
  
  
  
  
  public double dt() {
    return dt; 
  }
  
  
  public double dx() {
    return (plusX - minusX)/xPoints; 
  }
    
  
  public double[] setupInitialWave() {
    double[] u0 = new double[xPoints];
    for (int j = 0; j < xPoints; j++) {
         double x = (plusX - minusX)/xPoints*j + minusX;
         u0[j] = initialU(x);
      }
    return u0;
  }
  
   public double[] setupInitialSpeed() {
    double[] uPrime0 = new double[xPoints];
    for (int j = 0; j < xPoints; j++) {
         double x = (plusX - minusX)/xPoints*j + minusX;
         uPrime0[j] = intialUPrime(x);

    }
    return uPrime0;
  }
  
}
