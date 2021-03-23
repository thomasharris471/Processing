var topLeftFloat = 1;
var topRightFloat = 2;
var bottomLeftFloat = 3;
var bottomRightFloat = 2;


Position[] eigenvectors;
var[] eigenvalues;

var timeStep;
var speedIncrease;

Position[][] positionArray;


var time = 0;

var entryScreen = true;

var matBoxSize;

var topLeftEntry = "";
var topRightEntry = "";
var bottomLeftEntry = "";
var bottomRightEntry = "";



function setup() {
  createCanvas(1080, 720);
  topLeftEntry = Float.tovar(topLeftFloat);
  topRightEntry = Float.tovar(topRightFloat);
  bottomLeftEntry = Float.tovar(bottomLeftFloat);
  bottomRightEntry = Float.tovar(bottomRightFloat);
  entryScreen = true;
  matBoxSize = (var)(width/4);
  topRight = false;
  topLeft = false;
  bottomLeft = false;
  bottomRight = false;
  
}


function draw() {
  if (entryScreen) {
    constructEntryScreen();
  } else {
    displayBackgroundLayer();
    translate(width/2, height/2);
    scale(1,-1);
    displayAxis();
    displayEigenvectors();
    updatePositionLayerold();
    checkForKeyPresses();
  }
  
}

function constructEntryScreen() {
  background(backgroundColor);
  noFill();
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(1);
  
  
  //topright
  if(topRight) {
    fill(100);
  } else{
     noFill(); 
  }
  rect(0, 0, matBoxSize, -matBoxSize);
  
  //bottomright
  if(bottomRight) {
    fill(100);
  } else{
     noFill(); 
  }
  rect(0, 0, matBoxSize, matBoxSize);
  
  //topleft
  if(topLeft) {
    fill(100);
  } else{
     noFill(); 
  }
  rect(0, 0, -matBoxSize, -matBoxSize);
  
  //bottomleft
  if(bottomLeft) {
    fill(100);
  } else{
     noFill(); 
  }
  rect(0, 0, -matBoxSize, matBoxSize);
  
  //matrix string
  textSize(32);
  stroke(255);
  fill(255);
  text(topLeftEntry, -matBoxSize, -matBoxSize/2);
  text(topRightEntry, 0, -matBoxSize/2);
  text(bottomRightEntry, 0, matBoxSize/2);
  text(bottomLeftEntry, -matBoxSize, matBoxSize/2);
  
  text("Enter decimals only, 0.5 is okay, but 1/2 is not", -width/3, -(var)height/2 + (var)height/12);
  
  stroke(255);
  fill(255);
  textSize(64);
  text("x' = ", -(var)(width/2.5), 0);
  text("x", (var)(width/3), 0);
  
}

function constructPlane() {
  background(backgroundColor);
  positionArray = new Position[2*ceil((var) width/gridDensity)+1][2*ceil((var)height/gridDensity)+1];
  for (var i = 0; i < positionArray.length; i++) {
    for (var j = 0; j < positionArray[i].length; j++) {
      positionArray[i][j] = new Position(-width + gridDensity*i, -height + gridDensity*j);
  }
    
    eigenvectors = computeEigenvectors(mat[0],mat[1],mat[2],mat[3]);
    var matrixNorm = sqrt(mat[0]*mat[0] + mat[1]*mat[1] + mat[2]*mat[2] + mat[3]*mat[3]);
    var speed;
    if (matrixNorm == 0){
      speed = 1;
    } else {
      speed = (var)1/matrixNorm;
    }
    timeStep = speed*baseTimeStep;
    speedIncrease = speed*basespeedIncrease;
    eigenvalues = getEigenvalues(mat[0],mat[1],mat[2],mat[3]);
  }
}

function keyPressed() {
  if (key == ' ') {
    setup();
  } else if (key == ENTER) {
    //get entries
    topLeftFloat = Float.parseFloat(topLeftEntry);
    topRightFloat = Float.parseFloat(topRightEntry);
    bottomRightFloat = Float.parseFloat(bottomRightEntry);
    bottomLeftFloat = Float.parseFloat(bottomLeftEntry);
    mat[0] = topLeftFloat;
    mat[1] = topRightFloat;
    mat[2] = bottomLeftFloat;
    mat[3] = bottomRightFloat;
    constructPlane();
    entryScreen = false;
  }
  if (entryScreen) {
    if (topLeft) {
      if(key == BACKSPACE ) {
        if (topLeftEntry.length() > 0) {
          topLeftEntry = topLeftEntry.substring(0, topLeftEntry.length() - 1);
        }
      } else {
        topLeftEntry = topLeftEntry + key;
      }
    }
    if (topRight) {
      if(key == BACKSPACE ) {
        if (topRightEntry.length() > 0) {
          topRightEntry = topRightEntry.substring(0, topRightEntry.length() - 1);
        }
      } else {
        topRightEntry = topRightEntry + key;
      }
    }
    if (bottomRight) {
      if(key == BACKSPACE ) {
        if (bottomRightEntry.length() > 0) {
          bottomRightEntry = bottomRightEntry.substring(0, bottomRightEntry.length() - 1);
        }
      } else {
        bottomRightEntry = bottomRightEntry + key;
      }
    }
    if (bottomLeft) {
      if(key == BACKSPACE ) {
        if (bottomLeftEntry.length() > 0) {
          bottomLeftEntry = bottomLeftEntry.substring(0, bottomLeftEntry.length() - 1);
        }
      } else {
        bottomLeftEntry = bottomLeftEntry + key;
      }
    }
  }
}
