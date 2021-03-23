float x = 8;
float y = 2;
float z = 6;


float a = 13;
float b = 28;
float c = 8/3;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(800,600, P3D);
  background(0);
  colorMode(HSB);
  smooth();
}

void draw() {
  background(0);
  stroke(255);

  
  for (int j = 0; j < 20; j++) {
    float dt = 0.001;
    float dx = a*(y-x);
    float dy = x*(b - z) - y;
    float dz = x*y - c*z;
    x = x + dx*dt;
    y = y + dy*dt;
    z = z + dz*dt;
    points.add(new PVector(x,y,z));
  }

 
  
  translate(width/2,height/2);
  scale(5);
  rotateY((float)frameCount/100);
//  point(x,y,z);
noFill();
strokeWeight(.5);
beginShape();
float hu = 0;
    for (PVector v : points) {
      stroke(hu,255,255);
     vertex(v.x, v.y, v.z);
     hu = hu + .005;
     if (hu > 255) {
       hu = 0;
     }
  }
  endShape();
  
}
