
void displayBackground() {
  fill(0,0,0,50);
  rect(-width/2,-height/2,width,height);
}

void displayParticles() {
  noStroke();
  fill(255,255,255,255);
  for (int i = 0; i < particles.size(); i++) {
    if (particles.get(i).q < 0) {
      fill(0,0,255); 
    } else if (particles.get(i).q > 0) {
      fill(255,0,0);
    } else {
      fill(255,255,255);
    }
    float m = particles.get(i).m;
    ellipse(particles.get(i).cur.x, particles.get(i).cur.y, sqrt(m), sqrt(m)); 
  }
}
