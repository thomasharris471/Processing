

Position[] computeEigenvectors(float a, float b, float c, float d) {
  Position eigen1 = new Position(-1,1);
  Position eigen2 = new Position(0,0);
  eigen1.isReal = false;
  eigen2.isReal = false;
  Position[] arr = {eigen1, eigen2};
  
  float discriminant = (a+d)*(a+d) - 4*(a*d-b*c);
  
  if(discriminant >= 0) {
    float lambda1 = ((a+d) + sqrt(discriminant))/2;
    float lambda2 = ((a+d) - sqrt(discriminant))/2;
    if ((b == 0 && lambda1 - a == 0) || (c == 0 && lambda2 - d == 0)) { 
      float eigenholder1 = lambda1;
      float eigenholder2 = lambda2;
      lambda1 = eigenholder2;
      lambda2 = eigenholder1;
    }
    eigen1.x = b;
    eigen1.y = lambda1 - a;
    eigen1.eigenvalue = lambda1;
    eigen2.x = lambda2 - d;
    eigen2.y = c;
    eigen2.eigenvalue = lambda2;
    if(abs(eigen1.x) + abs(eigen1.y) + abs(eigen2.x) + abs(eigen2.y) > 0) {
      
      
      eigen1.isReal = true;
      eigen2.isReal = true;   
      /*
      println(eigen1.eigenvalue);
      println(eigen1.x);
      println(eigen1.y);
      println(eigen2.eigenvalue);
      println(eigen2.x);
      println(eigen2.y);
      */
    }
    } 
    return arr; 
  } 
  

float computeSpeed(float a, float b, float c, float d) {
  float discriminant = (a+d)*(a+d) - 4*(a*d-b*c);
  float norm = sqrt(pow(a+d,2) + abs(discriminant))/2;
  float speed;
  if (norm == 0) {
    speed = 1;
  } else {
    speed = (float) 1/norm;
  }
  return speed;
}

float[][] getEigenvalues(float a, float b, float c, float d) {
  float[][] eigenvalues = {{0,0},{0,0}};
  float discriminant = (a+d)*(a+d) - 4*(a*d-b*c);
  if (discriminant > 0 || discriminant == 0) {
    float lambda1 = ((a+d) + sqrt(discriminant))/2;
    float lambda2 = ((a+d) - sqrt(discriminant))/2;
    eigenvalues[0][0] = lambda1;
    eigenvalues[1][0] = lambda2;
  } else {
    float rePart = (a+d)/2;
    float imPart = sqrt(-discriminant)/2;
    eigenvalues[0][0] = rePart;
    eigenvalues[0][1] = imPart;
    eigenvalues[1][0] = rePart;
    eigenvalues[1][1] = imPart;
  }
  
  return eigenvalues;
}

float matrixNorm(float a, float b, float c, float d) {
  
  return sqrt(a*a + b*b + c*c + d*d);
}
  
