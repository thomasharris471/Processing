int numberOfParticles;
float[] xPos;
float[] yPos;
float particleRadius;

void setup() {
  size(1200, 600);
  numberOfParticles = 100000;
  particleRadius = 5;
  xPos = new float[numberOfParticles];
  yPos = new float[numberOfParticles];
  for(int i = 0; i < numberOfParticles; i++) {
    xPos[i] = width/2;
    yPos[i] = height/2;
  }
}

void draw() {
  background(0);
  for (int i = 0; i < numberOfParticles; i++) {
    ellipse(xPos[i], yPos[i], particleRadius, particleRadius);
    xPos[i] += random(-5,5);
    yPos[i] += random(-5,5);
  }
  saveFrame("goloutput/gol_####.png");
}
