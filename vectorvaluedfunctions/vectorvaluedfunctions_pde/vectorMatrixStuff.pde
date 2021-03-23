boolean randomMode = false;

void vectorsandmatrix() {
    //vectors
   basevectors = new ArrayList<tVector>();
   basevectors.add(new tVector(-1,2));
//   basevectors.add(new tVector(0, 4));
  
  
  //matrix
  // [2, -3]
  // [0, 1]
   transform = new tMatrix(-2, 4, -3, -2);
}

tMatrix mat(float t) {
  return new tMatrix(cos(t), sin(t), -sin(t), cos(t)); 
}
