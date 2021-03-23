void displayBackgroundLayer() {
  fill(backgroundColor,backgroundOpacity);
  rect(0,0,width,height);
  
}

void displayAxis() {
  stroke(axisColor,axisOpacity);
  line(-100,0,100,0);
  line(0,-100,0,100);
  
}

void displayEigenvectors() {
  
  Position eigenvector1 = eigenvectors[0];
  Position eigenvector2 = eigenvectors[1];
  if(eigenvector1.isReal && eigenvector2.isReal) {
    stroke(45,245,0,30);
    float modifierX = sqrt(pow(eigenvector1.x,2) + pow(eigenvector1.y,2));
    float modifierY =sqrt(pow(eigenvector2.x,2) + pow(eigenvector2.y,2));
    line(0, 0, height*eigenvector1.x/modifierX, height*eigenvector1.y/modifierX);
    line(0, 0, -height*eigenvector1.x/modifierX, -height*eigenvector1.y/modifierX);
    line(0, 0, height*eigenvector2.x/modifierY, height*eigenvector2.y/modifierY);
    line(0, 0, -height*eigenvector2.x/modifierY, -height*eigenvector2.y/modifierY);

    pushMatrix();
    scale(1,-1);
    textSize(26);
    fill(eigenvectorColor,eigenvectorOpacity);
    text(eigenvector1.eigenvalue,(float) height*eigenvector1.x/modifierX/3, (float)-height*eigenvector1.y/modifierX/3);
    if(eigenvector1.eigenvalue == eigenvector2.eigenvalue) {
    } else {
      text(eigenvector2.eigenvalue,(float) height*eigenvector2.x/modifierY/3, (float)-height*eigenvector2.y/modifierY/3);
    }
    popMatrix();
  } else {
    float rePart = eigenvalues[0][0];
    float imPart = eigenvalues[0][1];
    pushMatrix();
    scale(1,-1);
    textSize(26);
    fill(eigenvectorColor,eigenvectorOpacity);
    text(rePart + "\u00B1 i" + imPart,(float) width/4, 0);
    popMatrix();
  }
  
}

void updatePositionLayerold() {
  float currentX;
  float currentY;
  stroke(strokeColor,strokeOpacity);
  strokeWeight(weightOfStroke);
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      currentX = positionArray[i][j].x;
      currentY = positionArray[i][j].y;
      line(currentX, currentY, currentX + xPrimeLinear(currentX, currentY, time)*timeStep, currentY + yPrimeLinear(currentX, currentY, time)*timeStep);
      currentX = currentX + xPrimeLinear(currentX, currentY, time)*timeStep;
      currentY = currentY + yPrimeLinear(currentX, currentY, time)*timeStep;
      positionArray[i][j].x = currentX;
      positionArray[i][j].y = currentY;
    }
  }
  
}

float xPrimeLinear(float x, float y, float t) {
  return (float)mat[0]*x + (float)mat[1]*y;
}

float yPrimeLinear(float x, float y, float t) {
  return  (float)mat[2]*x  + (float)mat[3]*y;
}




void checkForKeyPresses(){ 
  //checking for key presses
  if ((keyPressed == true) && (key == 'A' || key == 'a')) {
    timeStep = timeStep + speedIncrease;
  } 
  else if ((keyPressed == true) && (key == 'S' || key == 's')) {
    timeStep = timeStep - speedIncrease;
  } 
}
  











class Position {
 
  float x;
  float y;
  boolean isReal;
  float eigenvalue;
  
  Position(float xPos, float yPos) {
    x = xPos;
    y = yPos;
  }
  
}


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
    }
    } 
    return arr; 
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
