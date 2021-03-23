int xWidth = 500;
int yWidth = 300;

PGraphics circle;

PGraphics grid;


void setup() {
  size(500, 300);
  background(255);
  
  circle = createGraphics(100,100);
  circle.beginDraw();
  circle.background(255);
  circle.line(0,0,100,0);
  circle.endDraw();
  
  grid = createGraphics(width, height);
  grid.beginDraw();
  for (int j = 0; j < width/10; j++) {
    grid.line(10*j - width/2, -height/2, 10*j - width/2, height/2);
  }
  for (int j = 0; j < height/10; j++) {
    grid.line(-width/2, 10*j - height/2, width/2, 10*j - height/2);
  }
  grid.endDraw();
  
}


void draw() {
  background(255);
  pushMatrix();
    
  translate(width/4, height/4);

  shearX(-radians(frameCount % 360));
    image(grid, width/4, height/4);
  popMatrix();
  
}


  
