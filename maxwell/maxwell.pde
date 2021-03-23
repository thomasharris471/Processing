ArrayList<Particle> particles;

Particle electron;

float[] elecPos = {0,0};

int numberOfParticles = 1;

float dt = 1;

void setup() {
  size(600,600);
  particles = new ArrayList<Particle>();
  
  electron = new Particle();
  electron.xPos = elecPos[0];
  electron.yPos = elecPos[1];
}

void draw() {
  background(0);
  translate(width/2,height/2);
//  electron.xPos = 10*cos(2*PI*(float)frameCount/79);
  electron.yPos = 10*sin(2*PI*(float)frameCount/50);
  createParticles();
  drawParticles();
  updateParticlePostitions();
  pruneSize();
}

void pruneSize() {
  if (particles.size() > 100000) {
    //particles.removeRange(0,100);
  }
}

void drawParticles() {
  stroke(255,255,255,255);
  fill(255);
  for (int i = 0; i < particles.size(); i++) {
    ellipse(particles.get(i).xPos,particles.get(i).yPos,1,1); 
  }
}

void createParticles() {
  for (int i = 0; i < numberOfParticles; i++) {
    float xs = cos(2*PI*(float)i/numberOfParticles);
    float ys = sin(2*PI*(float)i/numberOfParticles);
    particles.add(new Particle(xs, ys, electron.xPos, electron.yPos));
  }
}

void updateParticlePostitions() {
  for (int i = 0; i < particles.size(); i++) {
    float xp = particles.get(i).xPos;
    float yp = particles.get(i).yPos;
    float xs = particles.get(i).xSpeed;
    float ys = particles.get(i).ySpeed;
    particles.get(i).xPos = xp + dt*xs;
    particles.get(i).yPos = yp + dt*ys;
  }
}

class Particle {
  
  float xSpeed;
  float ySpeed;
  
  float xPos;
  float yPos;
  
  Particle() {
  }
  
  Particle(float xs, float ys, float xp, float yp) {
     xSpeed = xs;
     ySpeed = ys;
     xPos = xp;
     yPos = yp;
  }
}
