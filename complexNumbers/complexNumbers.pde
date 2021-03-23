Vector v;

Vector baseVector;

double rotateTime;
double scaleTime;

int numRotations;
int numScales;

void setup() {
  size(1080,900);
  v = new Vector(x0, y0);
  baseVector = new Vector(x0, y0);
  rotateTime = 0;
  scaleTime = 0;
  numRotations = 0;
  numScales = 0;
}

void draw() {
  background(backgroundColor);
  translate(width/2, height/2);
  scale(1,-1);
  commands();
}


void displayTriangle() {
  stroke(vectorColor);
  double xVal = v.getX();
  double yVal = v.getY();
  displayLine(xVal,0, xVal, yVal);
  displayLine(0,0,xVal,0);
}

void displayAngleArc() {
  noFill();
  ellipseMode(RADIUS);
  stroke(actionColor);
  push();
  displayArc(0, 0, tickDistance, tickDistance, 0, v.getTheta());
  pop();
}

void keyTyped() {
  if (key == 'r') {
    numRotations++;
  }
  if (key == 's') {
    numScales++;
  }
  if (key == 'x') {
    reset(); 
  }
  if (key == 'y') {
     displayY = !displayY;
  }
  if (key == 'n') {
     displayNumbers = !displayNumbers;
  }
  if (key == 't') {
    displayTriangle = !displayTriangle;
  }
  if (key == 'l') {
     displaytriangletext = !displaytriangletext;
  }
  if (key == 'm') {
    displaytheta = !displaytheta;
  }
  if (key == 'v') {
   velocityvector = !velocityvector; 
  }
  if (key == 'b') {
    translatedvelocityvector =!translatedvelocityvector;
  }
}


void displayLetterTheta() {
  textSize(20);
  fill(green);
  displayText("\u03B8", tickDistance/4, tickDistance/4);
}

void displayTriangleText() {
  textSize(20);
  fill(green);
  displayText("x = r cos(" + "\u03B8" + ")", v.getX()/2, -tickDistance/2);
  displayText(" i y = i r sin(" + "\u03B8" + ")", v.getX(), v.getY()/2);
  displayText(" r exp(i" + "\u03B8" + ")", v.getX(), v.getY());
}

void reset() {
  v = new Vector(x0, y0); 
  numRotations = 0;
  numScales = 0;
  rotateTime = 0;
  scaleTime = 0;
}

void displayTranslated() {
  push();
  Vector h = new Vector(v.getX(), v.getY());
  h.rotate(Math.PI/2);
   stroke(vectorColor);
  strokeWeight(3);
  displayArrow(h.getX(), h.getY());
  pop();
}

void displayVelocityVector() {
  push();
  tomTranslate(v.getX(), v.getY());
  Vector h = new Vector(v.getX(), v.getY());
  h.rotate(Math.PI/2);
   stroke(vectorColor);
  strokeWeight(3);
  displayArrow(h.getX(), h.getY());
  pop();
}


void transformVector() {
  if (rotateTime <= rotateTimeInterval && numRotations > 0) {
    rotateVector(theta);
    rotateTime = rotateTime + dt;
    if (rotateTime > rotateTimeInterval) {
      numRotations--;
      rotateTime = 0;
    }
  }
  if (scaleTime <= scaleTimeInterval && numScales > 0) {
     scaleVector(r);
     scaleTime = scaleTime + dt;
     if (scaleTime > scaleTimeInterval) {
       numScales--;
       scaleTime = 0;
     }
   }
}

void displayGrid() {
  stroke(gridColor);
  fill(gridColor);
  textSize(32);
  displayLine(xAxis[0], 0, xAxis[1], 0);

  for (double i = 0; i <= xAxis[1]; i = i + tickDistance) {
     displayLine(i, -tickSize, i, tickSize);
  }
  for (double i = -tickDistance; i >= xAxis[0]; i = i - tickDistance) {
     displayLine(i, -tickSize, i, tickSize);
  }
  displayText("x", xAxis[1]/2, -tickDistance/2);
  displayText("0", 0, -tickDistance/2);
  if (displayY) {
      displayLine(0, yAxis[0], 0, yAxis[1]);
    for (double i = tickDistance; i <= yAxis[1]; i = i + tickDistance) {
       displayLine(-tickSize, i, tickSize, i);
    }
    for (double i = -tickDistance; i >= yAxis[0]; i = i - tickDistance) {
       displayLine(-tickSize, i, tickSize, i);
    }
  
  
    displayText("i y", 0, yAxis[1]/2);
  }
  if(displayNumbers) {
    for (double i = 0; i <= xAxis[1]; i = i + tickDistance) {
      displayText(String.valueOf(i), i, -tickDistance/2);
    }
    for (double i = -tickDistance; i >= xAxis[0]; i = i - tickDistance) {
      displayText(String.valueOf(i), i, -tickDistance/2);
    }
    if(displayY) {
      for (double i = tickDistance; i <= yAxis[1]; i = i + tickDistance) {
       displayText("i" +String.valueOf(i), -tickDistance, i);
    }
    for (double i = -tickDistance; i >= yAxis[0]; i = i - tickDistance) {
        displayText("-i" + String.valueOf(-i), -tickDistance, i);
    }
    }
  
  }
}

void displayVector() {
  stroke(vectorColor);
  strokeWeight(3);
  displayArrow(v.getX(), v.getY());
//  displayLine(0, 0, v.getX(), v.getY());
}


void scaleVector(double rVal) {
  double power = interpolateFunc(0, scaleTimeInterval, scaleTime) ;
  double factor= Math.pow(rVal, power);
  v.scale(factor);
}

void rotateVector(double thetaVal) {
  double term = interpolateFunc(0, rotateTimeInterval, rotateTime);
  v.rotate(thetaVal*term);
}


double interpolateFunc(double startTime, double endTime, double time) {
   double omega = Math.PI/(endTime - startTime);
   double phase = startTime;
   return omega/2.0*Math.sin(omega*(time - phase))*dt;
}

void displayText(String str, double x, double y) {
   displayText(str, (float) x, (float) y);
}

void displayText(String str, float x, float y) {
   PVector pPos = pixelScale(x,y);
   push();
   scale(1,-1);
   text(str, pPos.x, -pPos.y);
   pop();
}

 void displayArrow(double x, double y) {
      double mag = Math.sqrt(x*x + y*y);
     displayLine(0,0,x,y);
     push();
     tomTranslate(x,y);
     double rotationAngle;
     if (x == 0) {
       rotationAngle = PI/2; 
     } else if (x < 0){
      rotationAngle = Math.atan(y/x) + PI;
     } 
     else {
       rotationAngle = Math.atan(y/x);
     }
     rotate((float) rotationAngle);

     displayLine(0,0,-mag/10,mag/20);
     displayLine(0,0,-mag/10,-mag/20);
     pop();
  }
  
  void tomTranslate(double x, double y) {
  tomTranslate((float) x, (float) y); 
}
  
  void tomTranslate(float x, float y) {
  PVector pPos = pixelScale(x,y);
  translate(pPos.x, pPos.y);
}

void displayArc(float x, float y, float dx, float dy, float theta0, float theta1) {
  PVector pPos = pixelScale(x,y);
  PVector pD = pixelScale(dx, dy);
  arc(pPos.x, pPos.y, pD.x, pD.y, theta0, theta1);
}

void displayArc(double x, double y, double dx, double dy, double theta0, double theta1) {
  displayArc((float) x, (float) y, (float) dx, (float) dy, (float) theta0, (float) theta1);
}

void displayLine(double x0, double y0, double x1, double y1) {
  displayLine((float)x0, (float)y0, (float)x1, (float)y1);
}

void displayLine(float x0, float y0, float x1, float y1) {
  PVector p0 = pixelScale(x0, y0);
  PVector p1 = pixelScale(x1, y1);
  line(p0.x, p0.y, p1.x, p1.y);
}

PVector pixelScale(float x, float y) {
   float xPix = x*(width)/((float)(xAxis[1] - xAxis[0]));
   float yPix = y*(width)/((float)(yAxis[1] - yAxis[0]));
   return new PVector(xPix, yPix);
}
