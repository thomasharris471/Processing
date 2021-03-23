function displayBackgroundLayer() {
  fill(backgroundColor,backgroundOpacity);
  rect(0,0,width,height);
  
}

function displayAxis() {
  stroke(axisColor,axisOpacity);
  line(-100,0,100,0);
  line(0,-100,0,100);
  
}

function displayEigenvectors() {
  
  Position eigenvector1 = eigenvectors[0];
  Position eigenvector2 = eigenvectors[1];
  if(eigenvector1.isReal && eigenvector2.isReal) {
    stroke(45,245,0,30);
    var modifierX = sqrt(pow(eigenvector1.x,2) + pow(eigenvector1.y,2));
    var modifierY =sqrt(pow(eigenvector2.x,2) + pow(eigenvector2.y,2));
    line(0, 0, height*eigenvector1.x/modifierX, height*eigenvector1.y/modifierX);
    line(0, 0, -height*eigenvector1.x/modifierX, -height*eigenvector1.y/modifierX);
    line(0, 0, height*eigenvector2.x/modifierY, height*eigenvector2.y/modifierY);
    line(0, 0, -height*eigenvector2.x/modifierY, -height*eigenvector2.y/modifierY);

    push();
    scale(1,-1);
    textSize(26);
    fill(eigenvectorColor,eigenvectorOpacity);
    text(eigenvector1.eigenvalue,(var) height*eigenvector1.x/modifierX/3, (var)-height*eigenvector1.y/modifierX/3);
    if(eigenvector1.eigenvalue == eigenvector2.eigenvalue) {
    } else {
      text(eigenvector2.eigenvalue,(var) height*eigenvector2.x/modifierY/3, (var)-height*eigenvector2.y/modifierY/3);
    }
    pop();
  } else {
    var rePart = eigenvalues[0][0];
    var imPart = eigenvalues[0][1];
    push();
    scale(1,-1);
    textSize(26);
    fill(eigenvectorColor,eigenvectorOpacity);
    text(rePart + "\u00B1 i" + imPart,(var) width/4, 0);
    pop();
  }
  
}

function updatePositionLayerold() {
  var currentX;
  var currentY;
  stroke(strokeColor,strokeOpacity);
  strokeWeight(weightOfStroke);
  for (var i = 0; i < positionArray.length; i++) {
    for (var j = 0; j < positionArray[i].length; j++) {
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

var xPrimeLinear(var x, var y, var t) {
  return (var)mat[0]*x + (var)mat[1]*y;
}

var yPrimeLinear(var x, var y, var t) {
  return  (var)mat[2]*x  + (var)mat[3]*y;
}




function checkForKeyPresses(){ 
  //checking for key presses
  if ((keyPressed == true) && (key == 'A' || key == 'a')) {
    timeStep = timeStep + speedIncrease;
  } 
  else if ((keyPressed == true) && (key == 'S' || key == 's')) {
    timeStep = timeStep - speedIncrease;
  } 
}
  











class Position {
 
  var x;
  var y;
  var isReal;
  var eigenvalue;
  
  Position(var xPos, var yPos) {
    x = xPos;
    y = yPos;
  }
  
}


Position[] computeEigenvectors(var a, var b, var c, var d) {
  Position eigen1 = new Position(-1,1);
  Position eigen2 = new Position(0,0);
  eigen1.isReal = false;
  eigen2.isReal = false;
  Position[] arr = {eigen1, eigen2};
  
  var discriminant = (a+d)*(a+d) - 4*(a*d-b*c);
  
  if(discriminant >= 0) {
    var lambda1 = ((a+d) + sqrt(discriminant))/2;
    var lambda2 = ((a+d) - sqrt(discriminant))/2;
    if ((b == 0 && lambda1 - a == 0) || (c == 0 && lambda2 - d == 0)) { 
      var eigenholder1 = lambda1;
      var eigenholder2 = lambda2;
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
  
  var[] getEigenvalues(var a, var b, var c, var d) {
  var[] eigenvalues = {{0,0},{0,0}};
  var discriminant = (a+d)*(a+d) - 4*(a*d-b*c);
  if (discriminant > 0 || discriminant == 0) {
    var lambda1 = ((a+d) + sqrt(discriminant))/2;
    var lambda2 = ((a+d) - sqrt(discriminant))/2;
    eigenvalues[0][0] = lambda1;
    eigenvalues[1][0] = lambda2;
  } else {
    var rePart = (a+d)/2;
    var imPart = sqrt(-discriminant)/2;
    eigenvalues[0][0] = rePart;
    eigenvalues[0][1] = imPart;
    eigenvalues[1][0] = rePart;
    eigenvalues[1][1] = imPart;
  }
  
  return eigenvalues;
}
