ArrayList<PVector> pPoints;

void setup() {
  size(1080,720);
  initializeMassesAndSprings();
  attachObjectsInOrderFirstMassOnLeft();
  pPoints = new ArrayList<PVector>();
}

void draw() {
  background(backgroundColor);
  stroke(white);
  translate(width/2, height/2);
  displaySpring();
  displayMasses();
  displayGraph();
 displayAxis();
 if(eGraph) {
   
  displayEnergyGraph();
 }
 if (circle) {
  displayCircle();
 }
  
  for (int i = 0; i < stepsPerFrame; i++) {
    updatePositions();
     

  }
 
}



void displayMasses() {
  float xPixelCenter;
  float yPixelCenter;
  float masspixelWidth;
  float masspixelHeight;
  for (int i = 0; i < masses.size(); i++) {
    xPixelCenter = map(masses.get(i).currentPosition, xLength[0], xLength[1], -width/2, width/2);
    yPixelCenter = map(0, yLength[0], yLength[1], -height/2, height/2);
    masspixelWidth = width*masses.get(i).massLength/( xLength[1] - xLength[0]);
    masspixelHeight = height*masses.get(i).massHeight/( yLength[1] - yLength[0]);
    rectMode(CENTER);
    fill(white);
    stroke(white);
    rect(xPixelCenter, yPixelCenter, masspixelWidth, masspixelHeight);
  }
}

void displaySpring() {
  float xPixelP;
  float yPixelP;
  float xPixelN;
  float yPixelN;
  stroke(white);
  for (int i = 0; i < springs.size(); i++) {
    ArrayList<Node> n = springs.get(i).springNodes();
    for (int j = 0; j < n.size()-1; j++) {
       xPixelP  = map(n.get(j).x, xLength[0], xLength[1], -width/2, width/2);
       yPixelP = map(n.get(j).y, yLength[0], yLength[1], -height/2, height/2);
       xPixelN  = map(n.get(j+1).x, xLength[0], xLength[1], -width/2, width/2);
       yPixelN = map(n.get(j+1).y, yLength[0], yLength[1], -height/2, height/2);
       line(xPixelP, yPixelP, xPixelN, yPixelN);
       
    }
  }
  
}

void displayGraph() {
  stroke(green);
  for (int i = 0; i < masses.size(); i++) {
    if (masses.get(i).isWall) {
      //do nothing
    } else{
      for (int j = 0; j < masses.get(i).positions.size(); j = j + stepsPerFrame) {
        float pixel = map(masses.get(i).positions.get(j), xLength[0], xLength[1], -width/2, width/2);
        float yPixelCenter = map(0, yLength[0], yLength[1], -height/2, height/2);
       point(pixel, yPixelCenter + (float)(masses.get(i).positions.size() -  j) /stepsPerFrame); 
      }
    }
  }
}

PVector pixelPositions(float x, float y) {
  return new PVector(map(x, xLength[0], xLength[1], -width/2, width/2), map(y, yLength[0], yLength[1], -height/2, height/2));
}
