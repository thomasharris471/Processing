PGraphics pg;

void setup() {
  size(800,450);
  pg = createGraphics(width, height);

}


void draw() {
  background(255);
  translate(width/2, height/2);

  ellipse(0, 0, 100, 100);
  pushMatrix();
  rotate(-2*PI*(frameCount%300)/300);
  translate(100, 0);
  rotate(-2*PI*(frameCount%300)/300);
  
  ellipse(0, 0, 100, 100);
  ellipse(-50, 0, 30, 30);
  pg.beginDraw();
  pg.stroke(0);
  pg.line(20, 20, 80, 80);
  pg.ellipse(-50, 0, 60, 60);
  pg.endDraw();
  popMatrix();
  image(pg, 0, 0);
  
}
