ArrayList<Particle> particles;


void setup() {
  size(1280, 720);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < numberOfParticles; i++) {
    PVector p = new PVector(random(-100,100), random(-100,100));
    PVector v = new PVector(random(-10,10), random(-10,10));
    PVector prev = new PVector(p.x - v.x*dt, p.y - v.y*dt);
    float m = random(1, 100);
    float q = 100;
    Particle part = new Particle(p, prev, m, q);
    particles.add(part);
  }
  for (int i = 0; i < numberOfParticles; i++) {
    PVector p = new PVector(random(-100,100), random(-100,100));
    PVector v = new PVector(random(-10,10), random(-10,10));
    PVector prev = new PVector(p.x - v.x*dt, p.y - v.y*dt);
    float m = random(1, 100);
    float q = -100;
    Particle part = new Particle(p, prev, m, q);
    particles.add(part);
  }
  fill(0);
  rect(0,0,width,height);
}

void draw() {
  translate(width/2, height/2);
  displayBackground();
  displayParticles();
  for (int i = 0; i < stepsPerFrame; i++) {
    preUpdatePositions();
    updatePositions();
  }
}
