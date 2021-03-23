float laplacian(float h, float x, float y) {
  
  float xPart = (f(x+h,y) + f(x-h,y) - 2*f(x,y))/(h*h);
  float yPart = (f(x,y+h) + f(x,y-h) - 2*f(x,y))/(h*h);
  return xPart + yPart;
}

float sinhpart(int i, int j) {
  return (float)(Math.sin(zValues[i][j]));
}

float discreteLaplacian(int i, int j) {
  float xPart = (zValues[i+1][j] + zValues[i-1][j] - 2*zValues[i][j])/(scl*scl);
  float yPart = (zValues[i][j+1] + zValues[i][j-1] - 2*zValues[i][j])/(scl*scl);
  return xPart + yPart - sinhpart(i,j);
}

float purturbation(int i, int j) {
  float xPart = (zValues[i+1][j] + zValues[i-1][j] - 2*zValues[i][j])/(scl*scl);
  float yPart = (zValues[i][j+1] + zValues[i][j+1] - 2*zValues[i][j])/(scl*scl);
  return xPart + yPart;
}
