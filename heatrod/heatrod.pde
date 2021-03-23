Heat w;
double[] xAxis;
double[] yAxis = {-5, 5};

void setup() {
  size(800, 800);
  
  w = new Heat(new InitialConditions());
  xAxis = InitialConditions.xRange;
}

void draw() {
  background(0);
  displayHeat();
  for (int i = 0; i < InitialConditions.stepsPerFrame; i++) {
    w.update();
  }  
  
}

void displayHeat() {
  translate(width/2, height/2);
  scale(1,-1);
  stroke(255,255,255);
  double[] u = w.getHeat();
  for (int i = 0; i < u.length-1; i++) {
     float x0 = map(i, 0, u.length, (float)xAxis[0], (float) xAxis[1]);
     float x1 = map(i+1, 0, u.length, (float)xAxis[0], (float) xAxis[1]);
     displayLine(x0, (float)u[i], x1, (float)u[i+1]);
  }
  println((u[1]-u[0])/InitialConditions.dx);
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
