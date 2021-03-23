Star[] stars;

void setup() {
  size(640, 360, P2D);
  stars = new Star[10];
  for (int j = 0; j < stars.length; j++) {
    stars[j] = new Star();
  }
}


void draw() {
  if (frameCount%10 == 0) {
    
    background(51);
    for (int i = 0; i < stars.length; i++) {
      pushMatrix();
      translate(width/2 + stars[i].x, height/2 + stars[i].y);
      shape(stars[i].s);
      stars[i].x = stars[i].x + random(-5,5);
      stars[i].y = stars[i].y + random(-5,5);
      popMatrix();
    }
  }
}
