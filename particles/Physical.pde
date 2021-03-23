void preUpdatePositions() {
  for (int i = 0; i < particles.size(); i++) {
    PVector f = getForce(particles.get(i));
    particles.get(i).preUpdatePosition(f, dt);
  }
}

void updatePositions() {
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).updatePosition();
  }
}

PVector getForce(Particle p) {
  return p.getForces(particles);
}
