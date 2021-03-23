

void setup() {
  size(1080, 720);
  currentPositionLayer = createGraphics(width,height);
  background(backColor);
  positionArray = new Position[2*ceil((float) width/gridDensity)+1][2*ceil((float)height/gridDensity)+1];
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      positionArray[i][j] = new Position(-width + gridDensity*i, -height + gridDensity*j);
      //println(positionArray[i][j].x + "," + positionArray[i][j].y);
    }
  }
  stroke(strokeColor,strokeOpacity);
  strokeWeight(weightOfStroke);
  time = intialTime;
  
  
  if(linearmode){ 
    eigenvector1 = computeEigenvectors(mat[0],mat[1],mat[2],mat[3])[0];
    eigenvector2 = computeEigenvectors(mat[0],mat[1],mat[2],mat[3])[1];
    //float speed = computeSpeed(mat[0],mat[1],mat[2],mat[3]);
    float matrixNorm = matrixNorm(mat[0],mat[1],mat[2],mat[3]);
    float speed;
    if (matrixNorm == 0){
      speed = 1;
    } else {
      speed = (float)1/matrixNorm;
    }
    timeStep = speed*baseTimeStep;
    speedIncrease = speed*basespeedIncrease;
    eigenvalues = getEigenvalues(mat[0],mat[1],mat[2],mat[3]);
  }
  
}


void draw() {
  displayBackgroundLayer();
  translate(width/2, height/2);
  scale(1,-1);
  displayAxis();
  displayEigenvectors();
  scale(userScale,userScale);


  updatePositionLayerold();
  checkForKeyPresses();
  //image(currentPositionLayer,-width/2,-height/2);
  time = time + timeStep;
  
  
}







void checkForKeyPresses(){ 
  //checking for key presses
  if ((keyPressed == true) && (key == 'A' || key == 'a')) {
    timeStep = timeStep + speedIncrease;
  } 
  else if ((keyPressed == true) && (key == 'S' || key == 's')) {
    timeStep = timeStep - speedIncrease;
  } 
  else if ((keyPressed == true) && (key == 'C')) {
    userScale = userScale*(1 + userScaleIncrease);
  } 
  else if ((keyPressed == true) && (key == 'D')) {
    userScale = userScale*(1 - userScaleIncrease);
  } 
   else if ((keyPressed == true) && (key == 'F')) {
    backgroundOpacity = backgroundOpacity*(1 - tailLengthIncrease);
  } 
  
}
