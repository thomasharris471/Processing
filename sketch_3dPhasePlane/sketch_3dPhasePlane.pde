PVector[][][] positionArray;


PVector row1 = new PVector(int(random(-10, 10)), int(random(-10, 10)), int(random(-10, 10)));
PVector row2 = new PVector(int(random(-10, 10)), int(random(-10, 10)), int(random(-10, 10)));
PVector row3 = new PVector(int(random(-10, 10)), int(random(-10, 10)), int(random(-10, 10)));

int arrayLength = 10;
int depth = 600;

float timeStep = 0.0001;

void setup() {
  size(800,800,P3D);
  depth = width;
  background(0);
  positionArray = new PVector[arrayLength][arrayLength][arrayLength];
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      for (int k = 0; k < positionArray[i][j].length; k++) {
        positionArray[i][j][k] = new PVector(-width/2 + width/arrayLength*i, -height/2 + height/arrayLength*j, -depth/2 + depth/arrayLength*k);
      }
    }
  }
}

void draw() {
  fill(0,0,0,20);
  noStroke();
  translate(width/2, height/2, 0);
  box(width,height,10*depth);
  rotateY(PI/20);
  rotateX(PI/20);
  updatePositions();
  sphere(1);
  line(-width, 0, 0, width, 0, 0);
  line(0, -height, 0, 0, height, 0);
  line(0, 0, -depth, 0, 0, depth);
}


void updatePositions() {
 PVector cVec;
 PVector prime;
 stroke(255);
 for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      for (int k = 0; k < positionArray[i][j].length; k++) {
        cVec = positionArray[i][j][k];
        prime = primeMatrix(cVec);
        line(cVec.x, cVec.y, cVec.z, cVec.x + prime.x*timeStep, cVec.y + prime.y*timeStep, cVec.z + prime.z*timeStep);
        cVec.x = cVec.x + prime.x*timeStep;
        cVec.y = cVec.y + prime.y*timeStep;
        cVec.z = cVec.z + prime.z*timeStep;
      }
    }
  }
 
}


PVector primeMatrix(PVector currentPosition) {
  return new PVector(row1.dot(currentPosition), row2.dot(currentPosition),row3.dot(currentPosition));
}
