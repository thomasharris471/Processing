class Particle {
  
  PVector cur;
  PVector prev;
  float m;
  
  PVector curNext;
  PVector prevNext;
  
  float q;
  
   
  Particle(PVector cur, PVector prev, float m) {
    this.cur = cur.copy();
    this.prev = prev.copy();
    this.m = m;
    this.q = 0;
    
    this.prevNext = prev.copy();
    this.curNext = cur.copy();
  }
  
  Particle(PVector cur, PVector prev, float m, float q) {
    this.cur = cur.copy();
    this.prev = prev.copy();
    this.m = m;
    this.q = q;
    
    this.prevNext = prev.copy();
    this.curNext = cur.copy();
  }
  
  PVector getAcceleration(PVector force) {
    return force.div(m);
  }
  
  PVector getForces(ArrayList<Particle> particles) {
    float Fx = 0;
    float Fy = 0;
    for (int i = 0; i < particles.size(); i++) {
      Particle oParticle = particles.get(i);
      float distance = cur.dist(oParticle.cur);
      if (distance == 0) {
        //do nothing
      } else {
        float px = (cur.x - oParticle.cur.x)/distance;
        float py = (cur.y - oParticle.cur.y)/distance;
        float oQ = oParticle.q;
        Fx = Fx + q*oQ*px/distance;
        Fy = Fy + q*oQ*py/distance;
      }
    }
    return new PVector(Fx,Fy); 
  }
  
  void updatePosition() {
    cur = curNext.copy();
    prev = prevNext.copy();
  }
  
  void preUpdatePosition(PVector force, float dt) {
    // f(t + dt) = f''(t) dt*dt + 2 f(t) - f(t - dt)
    PVector acc = this.getAcceleration(force);
    float dx = acc.x*pow(dt,2) + 2*cur.x - prev.x;
    float dy = acc.y*pow(dt,2) + 2*cur.y - prev.y;
    PVector curHolder = new PVector(dx, dy);
    prevNext = cur.copy();
    curNext = curHolder.copy();
  }
}
