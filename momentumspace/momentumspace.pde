float xAxis;
float yAxis;

ArrayList<PVector> positions;

void setup() {
  size(1080,720);
  currentDisplacement = initialDisplacement;
  previousDisplacement = initialDisplacement - initialVelocity*dt;
  currentTime = 0;
  xAxis = 0;
  yAxis = 0;
  positions = new ArrayList<PVector>();
}

void draw() {
  background(backgroundColor);
  translate(width/2, height/2);
  displayAxis();
  displayAXAxis();
  displayYAxis();
  displaySum();
  displayCircle();
  updatePositions();
  for (int i = 0; i < stepsPerFrame; i++) {
    updateSpring();
  }
}

void updatePositions() {
  positions.add(new PVector(xAxisValue(), yAxisValue()));
    if (positions.size() > 5000) {
       positions.subList(0,2000).clear(); 
    }
}



void displayAxis() {
  stroke(purple);
  fill(white);

  displayXYGraph(xString, yString, width, height);
}

void displayAXAxis() {
  stroke(green);
  
  if (true) {
    xAxis = xAxisValue();
  }
  
  PVector p = pixelScale(xAxis, 0);
  line(0,0, p.x, p.y);
}

void displayYAxis() {
  stroke(green);
  if (true) {
    yAxis = yAxisValue();
  }
  PVector p = pixelScale(xAxis, yAxis);
  line(p.x,0, p.x, p.y);
}

void displaySum() {
 stroke(white) ;
 PVector p = pixelScale(xAxis, yAxis);
 line(0,0, p.x, p.y);
}

void displayCircle() {
  stroke(white);
  for (int i = 0; i < positions.size(); i++) {
      PVector p = pixelScale(positions.get(i).x, positions.get(i).y);
      point(p.x, p.y);
  }
}


PVector pixelScale(float x, float y) {
   float xPix = x*width/(xRange[1] - xRange[0]);
   float yPix = y*width/(yRange[1] - yRange[0]);
   return new PVector(xPix, yPix);
}
