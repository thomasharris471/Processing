import peasy.*;
PeasyCam camera;

double x0;
double x1;
double y0;
double y1;

double dx;
double dy;

double u0;
double u1;

double dt;

GradientVectorField gV;

void setup() {
  size(800, 800, P3D);
  camera = new PeasyCam(this, width/2, height/2, 0, 500);
  x0 = InitialConditions.xRange[0];
  x1 = InitialConditions.xRange[1];
  y0 = InitialConditions.yRange[0];
  y1 = InitialConditions.yRange[1];
  
  u0 = InitialConditions.uRange[0];
  u1 = InitialConditions.uRange[1];
   
  dx = InitialConditions.dx;
  dy = InitialConditions.dy;
  
  dt = InitialConditions.dt;
  
  double x = Math.random()*(x1 - x0) + x0;
  double y = Math.random()*(y1 - y0) + y0;
  
  gV = new GradientVectorField(dx, dy, dt, x, y);
}

void draw() {
  background(0);
  noStroke();
  lights();
  displayFunction();
  displayBall();
  gV.updatePosition();
  displayGradfield();
  displayLevelSets();
  double x = gV.getX();
  double y = gV.getY();
  
  if (keyPressed && key == 'a') {
   gV.jiggleball();
  } 
  if(keyPressed && key == 'b') {
    gV.flipSign();
  }
  if (keyPressed && key == 'q') {
   gV.move(x - dx,y);
  } 
  if (keyPressed && key == 'w') {
   gV.move(x + dx,y);
  } 
  if (keyPressed && key == 'e') {
   gV.move(x ,y-dy);
  } 
  if (keyPressed && key == 'r') {
   gV.move(x ,y+dy);
  } 
}

void displayLevelSets() {
  strokeWeight(0.5);
  stroke(0,255,255);
   for (double x = x0; x < x1; x = x + dx) {
     for (double y = y0; y < y1; y = y + dy) {
       double gradX = gV.getgradX(x,y);
       double gradY = gV.getgradY(x,y);
       double u = InitialConditions.u(x,y);
       double unext = InitialConditions.u(x + gradY, y - gradX);
       
      float xVal = map((float)x,  (float)x0, (float)x1, 0, width);
      float yVal = map((float)y, (float)y0, (float)y1, 0, height);
      float uVal = map((float)u, (float)u0, (float)u1, -100, 100);
      float xVal1 = map((float)(x + gradY) ,  (float)x0, (float)x1, 0, width);
      float yVal1 = map((float)(y - gradX), (float)y0, (float)y1, 0, height);
      float uVal1 = map((float)unext, (float)u0, (float)u1, -100, 100);
  
    line(xVal, yVal, uVal, xVal1, yVal1, uVal1);
       
       
   }
}
}

void displayBall() {
  stroke(255,255,255);
  double x = gV.getX();
  double y = gV.getY();
  double uval = InitialConditions.u(x,y);
  
  displayPoint(x, y, uval);
}

void displayPoint(double x, double y, double u) {
   float xVal = map((float)x,  (float)x0, (float)x1, 0, width);
  float yVal = map((float)y, (float)y0, (float)y1, 0, height);
  float uVal = map((float)u, (float)u0, (float)u1, -100, 100);
  push();
  translate(xVal, yVal, uVal);
  
  sphere(10);
  pop();
}

void displayFunction() {
   
   strokeWeight(0.5);
   for (double x = x0; x < x1; x = x + dx) {
     for (double y = y0; y < y1; y = y + dy) {
       double u00 = InitialConditions.u(x,y);
       double u01 = InitialConditions.u(x,y+dy);
       double u10 = InitialConditions.u(x+dx,y);
       double u11 = InitialConditions.u(x+dx,y+dy);
       
      colorMode(HSB);
      float u11col = map((float)u11, (float)u0, (float)u1, 0, 255);
      fill(u11col, 100, 255);
      beginShape(TRIANGLES);
      tomVertex(x+dx, y+dy, u11);
      tomVertex(x+dx, y, u10);
      tomVertex(x, y+dy, u01);
      endShape();
      
      beginShape(TRIANGLES);
      float u00col = map((float)u00, (float)u0, (float)u1, 0, 255);
      fill(u00col, 100, 255);
      tomVertex(x, y, u00);
      tomVertex(x, y + dy, u01);
      tomVertex(x + dx, y, u10);
      endShape();
     }
   }
}

void displayGradfield() {
   stroke(255,0,0);
   strokeWeight(0.5);
   for (double x = x0; x < x1; x = x + dx) {
     for (double y = y0; y < y1; y = y + dy) {
       double gradX = gV.getgradX(x,y);
       double gradY = gV.getgradY(x,y);
       double u = InitialConditions.u(x,y);
       double unext = InitialConditions.u(x - gradX*dt, y - gradY*dt);
       
      float xVal = map((float)x,  (float)x0, (float)x1, 0, width);
      float yVal = map((float)y, (float)y0, (float)y1, 0, height);
      float uVal = map((float)u, (float)u0, (float)u1, -100, 100);
      float xVal1 = map((float)(x - gradX*dt) ,  (float)x0, (float)x1, 0, width);
      float yVal1 = map((float)(y - gradY*dt), (float)y0, (float)y1, 0, height);
      float uVal1 = map((float)unext, (float)u0, (float)u1, -100, 100);
  
    line(xVal, yVal, uVal, xVal1, yVal1, uVal1);
       
       
   }
}
}


void tomVertex(double x, double y, double u) {
  float xVal = map((float)x,  (float)x0, (float)x1, 0, width);
  float yVal = map((float)y, (float)y0, (float)y1, 0, height);
  float uVal = map((float)u, (float)u0, (float)u1, -100, 100);
  
  vertex(xVal, yVal, uVal);
}
   
 
 
