float scaleFactor;

float omega = 20;

void setup() {
  size(600,600);
  scaleFactor = (float)(height/2)/(range[1] - range[0]);
}

void draw() {
  background(backgroundColor);

  pushMatrix();
  translate(width/2, height/4);
  scale(1,-1);
  createAxis();
  plotf();
  popMatrix();
  translate(width/2, 3*height/4);
  scale(1,-1);
  createAxis();
  plotT();
  plotS();
  omega = omega + .01;
 // plotTransformcos(frequency);
}

void plotT() {
   stroke(plotColor);
   strokeWeight(plotstrokeWeight);
  for (int i = 0; i < width; i++) {
    float x0 = map(i, 0, width, -width/2, width/2);
    float x1 = map(i+1, 0, width, -width/2, width/2);
    float xVal0 = map(i, 0, width, domain[0], domain[1]);
    float xVal1 = map(i+1, 0, width, domain[0], domain[1]);
    line(x0,5*g(xVal0),x1,5*g(xVal1));
  }
}

void plotS() {
   stroke(45,245,0,160);
   strokeWeight(plotstrokeWeight);
  for (int i = 0; i < width; i++) {
    float x0 = map(i, 0, width, -width/2, width/2);
    float x1 = map(i+1, 0, width, -width/2, width/2);
    float xVal0 = map(i, 0, width, domain[0], domain[1]);
    float xVal1 = map(i+1, 0, width, domain[0], domain[1]);
    line(x0,5*c(xVal0),x1,5*c(xVal1));
  }
}

void plotTransformcos(float freq) {
  float integrateValue = 0;
  stroke(plotColor);
  strokeWeight(plotstrokeWeight);
  float step = map(dt, domain[0], domain[1], 0, width);
  for (int i = -width; i < width; i++) {
    float xVal = map(i, -5*width, 5*width, domain[0], domain[1]);
    float adt = (domain[1] - domain[0])/(10*width);
    integrateValue = integrateValue + cos(freq*xVal)*f(xVal)*adt;
  }
  ellipse(freq*10, integrateValue, 3, 3);
}

float g(float freq) {
   float integrateValue = 0;
  for (int i = -width; i < width; i++) {
    float xVal = map(i, -width, width, domain[0], domain[1]);
     float adt = (domain[1] - domain[0])/(2*width);
    integrateValue = integrateValue + cos(freq*xVal)*f(xVal)*adt;
  }
  return integrateValue;
}

float c(float freq) {
   float integrateValue = 0;
  for (int i = -width; i < width; i++) {
    float xVal = map(i, -width, width, domain[0], domain[1]);
    float adt = (domain[1] - domain[0])/(2*width);
    integrateValue = integrateValue + sin(freq*xVal)*f(xVal)*adt;
  }
  return integrateValue;
}



void createAxis() {
  stroke(axisColor);
  strokeWeight(axisstrokeWeight);
  line(-width, 0, width, 0);
  line(0, -height, 0, height);
}

void plotf() {
 stroke(plotColor);
 strokeWeight(plotstrokeWeight);
  for (int i = 0; i < width; i++) {
    float x0 = map(i, 0, width, -width/2, width/2);
    float x1 = map(i+1, 0, width, -width/2, width/2);
    float xVal0 = map(i, 0, width, domain[0], domain[1]);
    float xVal1 = map(i+1, 0, width, domain[0], domain[1]);
    line(x0,scaleFactor*f(xVal0),x1,scaleFactor*f(xVal1));
  }
}
