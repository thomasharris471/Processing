public class Wave {
  
  private int xPoints;
  private int yPoints;
  
  
  private int leftPoolXPoints;
  private int rightPoolXPoints;
  
  
  private double dxSquared;
  private double dySquared;
  private double cdtSquared;

  private double[][][] u;
  
  private double dt;
  
  private double time;
  
  private double frequency;
  
  
  public Wave(InitialConditions ic) {
    this(ic.setupInitialWave() , ic.setupInitialSpeed(), ic.dt, ic.dx, ic.dy, ic.c, ic.frequency);
  }
  
  public void update() {
     //updateInteriorWave();
    updateSpecialPool();
  }
  
  public double[][][] getWave() {
     return u;
  }
  
  
  
  //time invariant wave
  public Wave(double[][] u0, double[][] uPrime0, double dt, double dx, double dy, double c, double freq) {
    dxSquared = Math.pow(dx, 2);
    dySquared = Math.pow(dy, 2);
    cdtSquared = Math.pow(c*dt, 2);
    this.dt = dt;
    frequency = freq;
    time = 0;
    xPoints = u0.length;
    yPoints = u0[0].length;
 
    u = new double[3][xPoints][yPoints];
    for (int j = 0; j < xPoints; j++) {
      for (int k = 0;  k < yPoints; k++) {
        u[0][j][k] = u0[j][k];
        
      }
    }
    for (int j = 1; j < xPoints - 1; j++) {
      for (int k = 1;  k < yPoints - 1; k++) {
        u[1][j][k] = u[0][j][k] + dt*uPrime0[j][k] + cdtSquared/2.0*(uxx(0,j,k) + uyy(0,j,k));
      }
    }
    
    for (int j = 0; j < xPoints; j++) {
      u[1][j][0] = u[0][j][0]; 
      u[1][j][yPoints-1] = u[0][j][yPoints-1]; 
    }
    
    for (int k = 0; k < yPoints; k++) {
      u[1][0][k] = u[0][0][k]; 
      u[1][xPoints-1][k] = u[0][xPoints-1][k]; 
    }   
    
    
  }
  

  private void updateSpecialPool() {
    
    int leftPoolLeftBoundary = 0;
    int leftPoolRightBoundary = 1;
    
    int rightPoolRightBoundary = xPoints;
    
    int lowerBoundary = 0;
    int upperBoundary = yPoints;
    
    int distance = 20;
    
    int size = 1;
    
    int connectingRegionLower = yPoints/2   - distance;
    int connectingRegionUpper = yPoints/2  + size - distance;
    
    int connectingRegionLower2 = yPoints/2   + distance;
    int connectingRegionUpper2 =  yPoints/2  + size + distance;
    
    
    //leftpool
    computeNextWave(leftPoolLeftBoundary+1 , leftPoolRightBoundary, lowerBoundary + 1, upperBoundary - 1);
    
    //rightpool
    computeNextWave(leftPoolRightBoundary+1, rightPoolRightBoundary-1, lowerBoundary + 1, upperBoundary - 1);
    
    
    
    //right connecting region
  //  computeNextWave(rightPoolRightBoundary-1, rightPoolRightBoundary , connectingRegionLower + 1, connectingRegionUpper - 1);
  //  computeNextWave(rightPoolRightBoundary-1, rightPoolRightBoundary , connectingRegionLower2 + 1, connectingRegionUpper2 - 1);
    
    
    //left connecting region
  //  computeNextWave(leftPoolRightBoundary, leftPoolRightBoundary + 1, connectingRegionLower + 1, connectingRegionUpper - 1);
    //computeNextWave(leftPoolRightBoundary, leftPoolRightBoundary + 1, connectingRegionLower2 + 1, connectingRegionUpper2 - 1);
    int numberOfSlits = 5;
    for (int i = 0; i < numberOfSlits; i++) {
      computeNextWave(leftPoolRightBoundary, leftPoolRightBoundary + 1, i*distance + 50, i*distance + 50 + size) ;
    }
    
    //leftpool
    updateRegion(leftPoolLeftBoundary + 1, leftPoolRightBoundary, lowerBoundary + 1, upperBoundary - 1);
    
    //rightpool
    updateRegion(leftPoolRightBoundary+1, rightPoolRightBoundary-1, lowerBoundary + 1, upperBoundary - 1);
    
    
   //left connecting region
//   updateRegion(leftPoolRightBoundary, leftPoolRightBoundary + 1, connectingRegionLower + 1, connectingRegionUpper - 1);
//   updateRegion(leftPoolRightBoundary, leftPoolRightBoundary + 1, connectingRegionLower2 + 1, connectingRegionUpper2 - 1);
   for (int i = 0; i < numberOfSlits; i++) {
      updateRegion(leftPoolRightBoundary, leftPoolRightBoundary + 1, i*distance + 50, i*distance + 50 + size );
    }
   
   //right connection rgion
//   updateRegion(rightPoolRightBoundary-1, rightPoolRightBoundary , connectingRegionLower + 1, connectingRegionUpper - 1);
//   updateRegion(rightPoolRightBoundary-1, rightPoolRightBoundary , connectingRegionLower2 + 1, connectingRegionUpper2 - 1);
    
  //  if(extenalcount <= 71) {
   
     updateLeftBoundary();
   //  extenalcount++;
   // }
 //  updateRightBoundary();
   time = time + dt;
  }
  
  int extenalcount = 0;
  
  void updateLeftBoundary() {
    
    for (int k = 0; k < yPoints; k++) {
       u[1][0][k] = 5*Math.sin(frequency*time);
    }
  }
  
  void updateRightBoundary() {
    
    for (int k = 0; k < yPoints; k++) {
       u[1][xPoints-1][k] = -20*Math.sin(frequency*time);
    }
  }
  
  
  private void computeNextWave(int leftBoundary, int rightBoundary, int lowerBoundary, int upperBoundary) {
    for (int j = leftBoundary ; j < rightBoundary; j++) {
      for (int k = lowerBoundary; k < upperBoundary ; k++) {
         u[2][j][k] = uOfIPlusOneWave(1, j, k);
      }
    }
  }
  
  
  private void updateSubPoolInterior(int leftBoundary, int rightBoundary, int lowerBoundary, int upperBoundary) {
    computeNextWave(leftBoundary + 1, rightBoundary - 1, lowerBoundary + 1, upperBoundary - 1);
    updateRegion(leftBoundary + 1, rightBoundary - 1, lowerBoundary + 1, upperBoundary - 1);
  }
  
  private void updateRegion(int leftBoundary, int rightBoundary, int lowerBoundary, int upperBoundary) {
    for (int j = leftBoundary ; j < rightBoundary ; j++) {
      for (int k = lowerBoundary ; k < upperBoundary; k++) {
         u[0][j][k] = u[1][j][k];
         u[1][j][k] = u[2][j][k];
      }
    }
  }
  
  private void updateInteriorWave() {
    updateSubPoolInterior(0, xPoints, 0, yPoints);
    
  }
  
  
  
  
  
  private double uOfIPlusOneHeat(int i, int j, int k) {
    return u[i][j][k] + Math.sqrt(cdtSquared)*(uxx(i,j,k) + uyy(i,j,k)); 
  }
  
  private double uOfIPlusOneWave(int i, int j, int k) {
    return -u[i-1][j][k] + 2*u[i][j][k] + cdtSquared*(uxx(i,j,k) + uyy(i,j,k)); 
  }
  
  
  private double uxx(int i , int j, int k) {
     return (u[i][j-1][k] - 2*u[i][j][k] + u[i][j+1][k])/dxSquared;
  }
  
  private double uyy(int i , int j, int k) {
     return (u[i][j][k-1] - 2*u[i][j][k] + u[i][j][k+1])/dySquared;
  }
}
