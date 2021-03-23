boolean randomMode = false;

float lambda = 0;

float z = .9;

void vectorsandmatrix() {
    //vectors
   basevectors = new ArrayList<tVector>();
   basevectors.add(new tVector(1,-1));
//   basevectors.add(new tVector(0, 4));
  
  
  //matrix
  // [1 - \lambda, 2]
  // [3, 2 - \lambda]
   transform = new tMatrix(2-lambda, 1, z, 2-lambda);
}
