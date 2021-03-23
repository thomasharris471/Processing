PGraphics circle;

void setup() {
  size(500,500);
  noCursor();
  circle = createGraphics(width, height);
  circle.beginDraw();
  circle.background(0);
  circle.noStroke();
  circle.fill(255,100);
  circle.endDraw();
}

void draw() {
  image(circle, 0, 0);
  stroke(255);
  line(mouseX, 0, mouseX, height);
  line(0, mouseY, width, mouseY);

}

void mousePressed() {
  noStroke();
  fill(255, 100);
  circle.beginDraw();
  circle.ellipse(mouseX, mouseY, frameCount%100, frameCount%100);
  circle.endDraw();
}
