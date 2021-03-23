//region you see in the plot
final static float[] xRange = {-25, 25};
final static float[] yRange = {-25, 25};

ArrayList<tVector> basevectors;
tMatrix transform;

void vectorsandmatrix() {
    //vectors
   basevectors = new ArrayList<tVector>();
   basevectors.add(new tVector(1,2));
   basevectors.add(new tVector(-1, 4));
  
  //matrix
   transform = new tMatrix(4, 2, -3, 1);
}
