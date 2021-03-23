

void setup() {
   size(1280, 720);

}

void draw() {
  background(0);
  stroke(255);
  translate(width/2, height/2);
  scale(1, -1);
  displayEllipse(xCurrent, yCurrent, 1, 1);
  stroke(255,0,0);
  displayEllipse(0, 0, .5, .5);
  for (int i = 0; i < stepsPerFrame; i++) {
    updatePosition();
  }
}


double xCurrent = 10;
double xPrevious = 10;

double yCurrent = 0;
double yPrevious = 0;

int stepsPerFrame = 5000;

double stepSize = 0.001;

double length = 1000;
double[] xAxis = {-3*length, 3*length};
double[] yAxis = {-3*length, 3*length};

double a(double x, double y) {
  return Math.pow(1/(x*x+y*y),2); 
}

double xPP(double x, double y) {
  return -y*a(x,y);
}

double yPP(double x, double y) {
  return x*a(x,y); 
}

void updatePosition() {
  double xNext = Math.pow(stepSize, 2)*xPP(xCurrent, yCurrent) + 2*xCurrent - xPrevious;
  double yNext = Math.pow(stepSize, 2)*yPP(xCurrent, yCurrent) + 2*yCurrent - yPrevious;
  
  xPrevious = xCurrent;
  yPrevious = yCurrent;
  
  xCurrent = xNext;
  yCurrent = yNext;
}

void displayEllipse(float x, float y, float dx, float dy) {
  PVector pPos = pixelScale(x,y);
  PVector pD = pixelScale(dx, dy);
  ellipse(pPos.x, pPos.y, pD.x, pD.y);
}

void displayEllipse(double x0, double y0, double dx, double dy) {
  displayEllipse((float) x0, (float) y0, (float) dx, (float) dy);
}

PVector pixelScale(float x, float y) {
   float xPix = x*(width)/((float)(xAxis[1] - xAxis[0]));
   float yPix = y*(width)/((float)(yAxis[1] - yAxis[0]));
   return new PVector(xPix, yPix);
}
