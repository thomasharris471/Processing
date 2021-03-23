/*
void updatePositionLayer() {
    //displaying phase diagram
  currentPositionLayer.beginDraw();
  currentPositionLayer.fill(backColor,backgroundOpacity);
  currentPositionLayer.rect(0,0,width,height);
  currentPositionLayer.stroke(strokeColor,strokeOpacity);
  currentPositionLayer.translate((float) width/2, (float) height/2);
  currentPositionLayer.scale(1,-1);
  strokeWeight(weightOfStroke);
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      currentX = positionArray[i][j].x;
      currentY = positionArray[i][j].y;
      currentPositionLayer.line(currentX, currentY, currentX + xPrime(currentX, currentY, time)*timeStep, currentY + yPrime(currentX, currentY, time)*timeStep);
      currentX = currentX + xPrime(currentX, currentY, time)*timeStep;
      currentY = currentY + yPrime(currentX, currentY, time)*timeStep;
      positionArray[i][j].x = currentX;
      positionArray[i][j].y = currentY;
    }
  }
  currentPositionLayer.endDraw();
  
}
*/


void updatePositionLayerold() {
    //displaying phase diagram

  stroke(strokeColor,strokeOpacity);
  strokeWeight(weightOfStroke);
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      currentX = positionArray[i][j].x;
      currentY = positionArray[i][j].y;
      if (linearmode) {
        line(currentX, currentY, currentX + xPrimeLinear(currentX, currentY, time)*timeStep, currentY + yPrimeLinear(currentX, currentY, time)*timeStep);
             currentX = currentX + xPrimeLinear(currentX, currentY, time)*timeStep;
             currentY = currentY + yPrimeLinear(currentX, currentY, time)*timeStep;
      } else{
        line(currentX, currentY, currentX + xPrime(currentX, currentY, time)*timeStep, currentY + yPrime(currentX, currentY, time)*timeStep);
        currentX = currentX + xPrime(currentX, currentY, time)*timeStep;
        currentY = currentY + yPrime(currentX, currentY, time)*timeStep;
      }

      positionArray[i][j].x = currentX;
      positionArray[i][j].y = currentY;
    }
  }
  
}



void displayBackgroundLayer() {
  fill(backColor,backgroundOpacity);
  rect(0,0,width,height);
  
}

void displayEigenvectors() {
  
     //displaying eigenvector
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
    fill(45,245,0,30);
    text(eigenvector1.eigenvalue,(float) height*eigenvector1.x/modifierX/3, (float)-height*eigenvector1.y/modifierX/3);
    if(eigenvector1.eigenvalue == eigenvector2.eigenvalue) {
    } else {
      text(eigenvector2.eigenvalue,(float) height*eigenvector2.x/modifierY/3, (float)-height*eigenvector2.y/modifierY/3);
    }
    popMatrix();
  // println(modifierX);
  // println(modifierY);
    
  } else {
    float rePart = eigenvalues[0][0];
    float imPart = eigenvalues[0][1];
    pushMatrix();
    scale(1,-1);
    textSize(26);
    fill(45,245,0,30);
    text(rePart + "\u00B1 i" + imPart,(float) width/4, 0);
    popMatrix();
  }
  
}


void displayAxis() {
  
    //displaying axis
  stroke(162,24,170,30);
  line(-100,0,100,0);
  line(0,-100,0,100);
  
}
