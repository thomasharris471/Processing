tMatrix transform;

ArrayList<tVector> basevectors;




ArrayList<tVector> vectors;
OrthogonalShearScaleDecomposition qr;
OrthogonalShearScaleDecomposition qrs;

ArrayList<ArrayList<tVector>> basegridVectors;
ArrayList<ArrayList<tVector>> transformedgridVectors;


ArrayList<tVector> fundamentalVectors;
ArrayList<tVector> transformedfundamentalVectors;

void initialize() {
  
  vectorsandmatrix();
   
   
   
   
   
   //don't touch
   
   vectors = new ArrayList<tVector>();
   for (int i = 0; i < basevectors.size(); i++) {
     vectors.add(new tVector(basevectors.get(i)));
   }
   
   basegridVectors = new ArrayList<ArrayList<tVector>>();
   for (int i = 0; i < (yRange[1] - yRange[0])/gridStepY; i++) {
     ArrayList<tVector> row = new ArrayList<tVector>();
     for (int j = 0; j < (xRange[1] - xRange[0])/gridStepX; j++) {
       float xValue = gridStepX*j + floor(xRange[0]/gridStepX)*gridStepX;
       float yValue = gridStepY*i + floor(yRange[0]/gridStepY)*gridStepY;
       row.add(new tVector(xValue, yValue));
     }
     basegridVectors.add(row);
   }
   transformedgridVectors = new ArrayList<ArrayList<tVector>>();
   for (int i = 0; i < basegridVectors.size(); i++) {
    ArrayList<tVector> row = new ArrayList<tVector>();
    for (int j = 0; j < basegridVectors.get(i).size(); j++) {
      tVector v0 =  basegridVectors.get(i).get(j);
      row.add(v0);
    }
    transformedgridVectors.add(row);
  }
   
   
   qr = new OrthogonalShearScaleDecomposition(transform);
   qrs = new OrthogonalShearScaleDecomposition(transform);
   
   fundamentalVectors = new ArrayList<tVector>();
   fundamentalVectors.add(new tVector(1,0));
   fundamentalVectors.add(new tVector(0,1));
   
   transformedfundamentalVectors = new ArrayList<tVector>();
   transformedfundamentalVectors.add(new tVector(1,0));
   transformedfundamentalVectors.add(new tVector(0,1));
   
}


void updateVectors() {
  
  //this animation is simply interpolating the transformation
  
  
  tMatrix mat = mat(time);
  for (int i = 0; i < basevectors.size(); i++) {
    tVector v0 = basevectors.get(i);
    tVector v1 = multiply(mat, v0);
    vectors.set(i,v1);
  }
  
  
  for (int i = 0; i < basegridVectors.size(); i++) {
    for (int j = 0; j < basegridVectors.get(i).size(); j++) {
      tVector v0 =  basegridVectors.get(i).get(j);
      tVector v1 = multiply(mat, v0);
      transformedgridVectors.get(i).set(j,v1);
    }
   
  }
    for (int i = 0; i < fundamentalVectors.size(); i++) {
      tVector v0 =  fundamentalVectors.get(i);
      tVector v1 = multiply(mat, v0);
      transformedfundamentalVectors.set(i,v1);
    }
  

   

  time = time + dt;
  
  
}

void randomize() {
 // basevectors.set(0, new tVector(1,0));
 // basevectors.set(1, new tVector(0,1));
   basevectors.set(0, new tVector(0,0));
  basevectors.set(1, new tVector(0,0));
  transform = new tMatrix(random(xRange[0]/4, xRange[1]/4), random(xRange[0]/4, xRange[1]/4), random(xRange[0]/4, xRange[1]/4), random(xRange[0]/4, xRange[1]/4));
  qr = new OrthogonalShearScaleDecomposition(transform);
}
