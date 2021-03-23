import peasy.*;
PeasyCam camera;

Wave w;

void setup() {
  size(800, 800, P3D);
  
  w = new Wave(new InitialConditions());
  camera = new PeasyCam(this, width/2, height/2, 0, 500);
}

void draw() {
  background(0);
  noStroke();
  lights();
//  directionalLight(255,255,255, 0, -1, 0);
 // rotateX(PI/4);
 // rotateX(PI/4);
//  translate(0, height/2, -500);
  
  displayWave();
  for (int i = 0; i < InitialConditions.stepsPerFrame; i++) {
    w.update();
  }
 
}

void displayWave() {
 // noStroke();
  strokeWeight(.5);
  double[][][] u = w.getWave();
  int xPoints = u[0].length;
  int yPoints = u[0][0].length;
  for (int j = 0; j < xPoints-1; j++) {
    for (int k = 0; k < yPoints-1; k++) {
      float x0 = map(j, 0, xPoints-1, 0, width);
      float x1 = map(j+1, 0, xPoints-1, 0, width);
      float y0 = map(k, 0, yPoints-1, 0, height);
      float y1 = map(k+1, 0, yPoints-1, 0, height);
     
      float scale = 100;
      float u00 = (float)(scale*u[1][j][k]);
      float u01 = (float)(scale*u[1][j][k+1]);
      float u10 = (float)(scale*u[1][j+1][k]);
      float u11 = (float)(scale*u[1][j+1][k+1]);
      
      
      colorMode(HSB);
      fill(5*abs(map(u11, 0, 2*scale, 0, 255)), 255, 255);
      beginShape(TRIANGLES);
      vertex(x1, y1, u11);
      vertex(x1, y0, u10);
      vertex(x0, y1, u01);
      endShape();
      
      beginShape(TRIANGLES);
      fill(5*abs(map(u00, 0, 2*scale, 0, 255)), 255, 255);
      vertex(x0, y0, u00);
      vertex(x0, y1, u01);
      vertex(x1, y0, u10);
      endShape();
      
    }
  }
}
 
