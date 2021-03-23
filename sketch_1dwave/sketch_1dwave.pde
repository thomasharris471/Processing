Wave w;

double zMax;
double zMin;

double[][] u;

void setup() {
  size(600, 600);
  
  w = new Wave(new InitialConditions());
  
  zMax = InitialConditions.heightMax;
  zMin = InitialConditions.heightMin;
}

void draw() {
  
  background(0);
  translate(0,height/2);
  displayWave();
  for (int i = 0; i < InitialConditions.stepsPerFrame; i++) {
    w.update();
  }
}

void displayWave() {
  u = w.getWave();
  stroke(255,255,255);
  for (int i = 0; i < u[1].length-1; i++) {
//    point(i, 100*(float)u[1][i]);
float scale = 100;
    line(i, scale*(float)u[1][i], i+1, scale*(float)u[1][i+1]);
  }
}
 
