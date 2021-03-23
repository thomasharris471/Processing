double x;
double yEuler;
double yRunge;



void setup() {
  size(1280, 920);
  x = x0;
  yEuler = y0;
  yRunge = y0;
  
  translate(width/2, height/2);
  scale(1,-1);
  fill(0);
  displayEllipse(x0, y0);
  if(showExact) {
    displayExactSolution();
  }
 
}

void draw() {
  translate(width/2, height/2);
  scale(1,-1);
  displayGraph();
  

}


void keyPressed() {
  if (showEuler) {
    displayEuler();
  }
  if (showRunge) {
    displayRunge();
  }
  if (showError) {
    displayError();
  }
  updateOdes();
}


void updateOdes() {
  double xn = x + h;
  //euler
  yEuler = euler(x, yEuler);
  
  //runge
  yRunge = rungekutta(x, yRunge);
  //increase x
  x = xn; 
}






void displayEuler() {
  double xn = x + h;
  
  stroke(eulerColor);
  fill(eulerColor);
  double ynEuler = euler(x, yEuler);
  displayLine(x, yEuler, xn, ynEuler);
  displayEllipse(xn, ynEuler);
  
}

void displayRunge() {
  double xn = x + h;
  stroke(rungeColor);
   fill(rungeColor);
  double ynRunge = rungekutta(x, yRunge);
  displayLine(x, yRunge, xn, ynRunge);
  displayEllipse(xn, ynRunge);

  
}

void displayExactSolution() {
  stroke(exactColor);
  for (double xVal = 0; xVal < xRange[1]; xVal = xVal + h/10) {
     displayLine(xVal, yExact(xVal), xVal + h/10, yExact(xVal + h/10));
  }
  for (double xVal = 0; xVal > xRange[0]; xVal = xVal - h/10) {
     displayLine(xVal, yExact(xVal), xVal - h/10, yExact(xVal - h/10));
  }
}

void displayError() {
  double xn = x + h;
  
  double ynEuler = euler(x, yEuler);
  
  stroke(errorColor);
  displayLine(x, Math.abs(yEuler - yExact(x)), xn, Math.abs(ynEuler - yExact(xn)));
  
}






void displayGraph() {
  stroke(0);
  displayLine(xRange[0], 0, xRange[1], 0);
  displayLine(0, yRange[0], 0, yRange[1]);
  for (double i = 0; i < xRange[1]; i = i + h) {
    displayVerticalTick(i, 0);
  }
  for (double i = 0; i > xRange[0]; i = i - h) {
    displayVerticalTick(i, 0);
  }
  
}

void displayVerticalTick(double x0, double y0) {
  PVector p = convert(x0, y0);
  line(p.x, p.y - tickHeight, p.x, p.y + tickHeight);
}

void displayEllipse(double x0, double y0) {
  PVector p0 = convert(x0, y0);
  ellipse(p0.x, p0.y, ellipsesize, ellipsesize);
}

void displayLine(double x0, double y0, double x1, double y1) {
  PVector p0 = convert(x0, y0);
  PVector p1 = convert(x1, y1);
  line(p0.x, p0.y, p1.x, p1.y);
}

void displayPoint(double x, double y) {
  PVector pos = convert(x,y);
  point(pos.x, pos.y);
}

PVector convert(double x, double y) {
  float xVal = map((float)x, (float)xRange[0], (float)xRange[1], -width/2, width/2); 
  float yVal = map((float)y, (float)yRange[0], (float)yRange[1], -height/2, height/2); 
  return new PVector(xVal, yVal);
}
