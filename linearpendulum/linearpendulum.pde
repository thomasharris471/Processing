void setup() {
   size(1280, 720);
   initializePendulum();
}

void draw() {
  background(0);
  translate(width/3, height/3);
  displayPerson();
  packagePendulum();

  for (int i = 0; i < stepsPerFrame; i++) {
    updateValue();
  }
}



void packagePendulum() {
  displayCenterLine();
  displayPendulum();
  displayMass();
  displayTheta();

  displayLetterTheta();
//  displaySubTheta();
//  displayForce();
}

void displayPerson() {
  push();
  stroke(purple);
  fill(purple);
  tomTranslate(-length, length);
  //head
  displayEllipse(0,0,.18,.18);
  tomTranslate(0,.18);
  //torso
  displayLine(0,0,0,.7);
  //legs
  tomTranslate(0,.7);
  displayLine(0, 0, .4, .9);
  displayLine(0, 0, -.4, .9);
  pop();
}

void displayLetterTheta() {
  textSize(32);
  fill(green);
  displayText("\u03B8" + "(t)", 0, 0);
}

void displaySubTheta() {
  push();
  tomTranslate(length*Math.sin(theta), length*Math.cos(theta));
  displayTheta();
  pop();
}

void displayCenterLine() {
  stroke(purple);
  displayLine(0,-arcProportion*length, 0, arcProportion*length);
}

void displayForce() {
  double forceScale = length/(mass*gravity); 
  stroke(purple);
  push();
  tomTranslate(length*Math.sin(theta), length*Math.cos(theta));
  displayArrow(0,mass*gravity*forceScale);
  textSize(32);
  
  displayText("mg", 0, (float)(mass*gravity*forceScale));
  pop();
  push();
  rotate(-(float)theta);
  tomTranslate(0,length);
  displayArrow(-mass*gravity*Math.sin(theta)*forceScale,0);
//  tomTranslate(-mass*gravity*Math.sin(theta),0);
  displayArrow(0,mass*gravity*Math.cos(theta)*forceScale);

  pop();
}

void displayTheta() {
  noFill();
  ellipseMode(RADIUS);
  stroke(arcColor);
  push();
  rotate(PI/2);
  displayArc(0, 0, arcProportion*length, arcProportion*length, 0, -theta);
  scale(1,-1);
  displayArc(0, 0, arcProportion*length, arcProportion*length, 0, theta);
  pop();
  
}

void displayPendulum() {
  stroke(rodColor);
  displayLine(0,0, length*Math.sin(theta), length*Math.cos(theta));
}

void displayMass() {
  fill(massColor);
  displayEllipse(length*Math.sin(theta), length*Math.cos(theta), Math.pow(mass/ironDensity, 0.33), Math.pow(mass/ironDensity, 0.33));
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


void displayText(String str, double x, double y) {
   displayText(str, (float) x, (float) y);
}

void displayText(String str, float x, float y) {
   PVector pPos = pixelScale(x,y);
   text(str, pPos.x, pPos.y);
}
void tomTranslate(double x, double y) {
  tomTranslate((float) x, (float) y); 
}

void tomTranslate(float x, float y) {
  PVector pPos = pixelScale(x,y);
  translate(pPos.x, pPos.y);
}


void displayEllipse(float x, float y, float dx, float dy) {
  PVector pPos = pixelScale(x,y);
  PVector pD = pixelScale(dx, dy);
  ellipse(pPos.x, pPos.y, pD.x, pD.y);
}

void displayEllipse(double x0, double y0, double dx, double dy) {
  displayEllipse((float) x0, (float) y0, (float) dx, (float) dy);
}
void displayLine(float x0, float y0, float x1, float y1) {
  PVector p0 = pixelScale(x0, y0);
  PVector p1 = pixelScale(x1, y1);
  line(p0.x, p0.y, p1.x, p1.y);
}

void displayLine(double x0, double y0, double x1, double y1) {
  displayLine((float)x0, (float)y0, (float)x1, (float)y1);
}

void displayArc(float x, float y, float dx, float dy, float theta0, float theta1) {
  PVector pPos = pixelScale(x,y);
  PVector pD = pixelScale(dx, dy);
  arc(pPos.x, pPos.y, pD.x, pD.y, theta0, theta1);
}

void displayArc(double x, double y, double dx, double dy, double theta0, double theta1) {
  displayArc((float) x, (float) y, (float) dx, (float) dy, (float) theta0, (float) theta1);
}


PVector pixelScale(float x, float y) {
   float xPix = x*(width)/((float)(xAxis[1] - xAxis[0]));
   float yPix = y*(width)/((float)(yAxis[1] - yAxis[0]));
   return new PVector(xPix, yPix);
}
