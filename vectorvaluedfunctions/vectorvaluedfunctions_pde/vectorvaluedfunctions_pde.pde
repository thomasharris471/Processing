


void setup() {
  size(1080,720);
  initialize();
}

void draw() {
  background(backgroundColor);
  stroke(white);
  translate(width/2, height/2);
  scale(1,-1);
//  displayTransformedGrid();
  displayGrid();
  displayAxis();
//  displayFundamentalSquare();
  displayVectors();
  
 
  for (int i = 0; i < framesPerStep; i++) {
    updateVectors();
  }
}

void displayAxis() {
  stroke(purple);
  strokeWeight(4);
  PVector origin = pixelPositions(0,0);
  
  line(origin.x, -height/2, origin.x, height/2);
  line(-width/2, origin.y, width/2, origin.y);
}

void displayVectors() {
  stroke(white);
  strokeWeight(6);
  PVector origin = pixelPositions(0,0);
  for (int i = 0; i < vectors.size(); i++) {
    PVector vec = pixelPositions(vectors.get(i).x, vectors.get(i).y);
    line(origin.x, origin.y, vec.x, vec.y);
  }
 
}

void displayGrid() {
  stroke(purple);
  strokeWeight(1);
  for (int i = 0; i < basegridVectors.size()-1; i++) {
    for (int j = 0; j < basegridVectors.get(i).size()-1; j++) {
      tVector v0 =  basegridVectors.get(i).get(j);
      tVector v1 =  basegridVectors.get(i).get(j+1);
      tVector v2 =  basegridVectors.get(i+1).get(j);
      pixelLine(v0, v1);
      pixelLine(v0, v2);
    }
  }
}

void displayTransformedGrid() {
  stroke(green);
  strokeWeight(1);
  for (int i = 0; i < transformedgridVectors.size()-1; i++) {
    for (int j = 0; j < transformedgridVectors.get(i).size()-1; j++) {
      tVector v0 =  transformedgridVectors.get(i).get(j);
      tVector v1 =  transformedgridVectors.get(i).get(j+1);
      tVector v2 =  transformedgridVectors.get(i+1).get(j);
      pixelLine(v0, v1);
      pixelLine(v0, v2);
    }
  }
}

void displayFundamentalSquare() {
  PVector e1 = new PVector(transformedfundamentalVectors.get(0).x, transformedfundamentalVectors.get(0).y);
  PVector e2 = new PVector(transformedfundamentalVectors.get(1).x, transformedfundamentalVectors.get(1).y);
  PVector a00 = pixelPositions(0,0);
  PVector a12 = pixelPositions(e1.x,e1.y);
  PVector a21 = pixelPositions(e2.x, e2.y);
  PVector a22 = pixelPositions(e1.x+e2.x, e1.y+e2.y);
  noStroke();
  fill(white, 80);
  beginShape();
  vertex(a00.x, a00.y);
  vertex(a12.x, a12.y);
  vertex(a22.x, a22.y);
  vertex(a21.x, a21.y);
  vertex(a00.x, a00.y);
  endShape();
  strokeWeight(8);
  stroke(255, 0, 0);
  line(a00.x, a00.y, a12.x, a12.y);
  stroke(0,0,255);
  line(a00.x, a00.y, a21.x, a21.y);
}


void pixelLine(float x0, float y0, float x1, float y1) {
  PVector v0 = pixelPositions(x0, y0);
  PVector v1 = pixelPositions(x1, y1);
  line(v0.x, v0.y, v1.x, v1.y);
}

void pixelLine(tVector v0, tVector v1) {
  pixelLine(v0.x, v0.y, v1.x, v1.y);
}

PVector pixelPositions(float x, float y) {
  return new PVector(map(x, xRange[0], xRange[1], -width/2, width/2), map(y, yRange[0], yRange[1], -width/2*aspectRatio, width/2*aspectRatio));
}

PVector pixelPositions(tVector v) {
  return pixelPositions(v.x, v.y);
}

PVector pixelPositions(PVector v) {
  return pixelPositions(v.x, v.y);
}
