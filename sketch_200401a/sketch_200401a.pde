int radius;
float angleInRadians;
int index;
int xCenter;
int yCenter;
int maxNumberOfSides;

void setup() {
  index = 1;
  radius = 50;
  maxNumberOfSides = 10;
  size(500, 500);
  xCenter = width/2;
  yCenter = height/2;
}

void draw() {
  if (frameCount % 10 == 0) {
    background(255);
    angleInRadians = 2*PI/index;
    translate(xCenter, yCenter);
    for (int i = 0; i < index; i++) {
      line(radius*cos(angleInRadians*i), radius*sin(angleInRadians*i),  radius*cos(angleInRadians*(i+1)), radius*sin(angleInRadians*(i+1)));
    }
    index = (index + 1) % maxNumberOfSides;
  }
}
