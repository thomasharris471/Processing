float computeD() {
  float springK = springs.get(0).k;
  float force = springs.get(0).getForce();
  return force/springK; 
}

float computeV() {
  float currentP = masses.get(1).currentPosition;
  float previousP = masses.get(1).previousPosition;
  return (currentP - previousP)/dt;
}

void displayAxis() {
  stroke(purple);
  strokeWeight(1);
  PVector p = pixelPositions((xLength[1] - xLength[0])/1.5,0);
  push();
  translate(p.x, p.y);
  line(0, -height/4, 0,  height/4);
  line(-width/4,0, width/4,0);
  textSize(32);
  fill(purple);
  text("x", -width/4, 0);
  text("x'", 0, -height/5);
  pop();
}



void displayEnergyGraph() {
  stroke(green);
  strokeWeight(2);
  PVector p = pixelPositions((xLength[1] - xLength[0])/1.5,0);
  push();
  translate(p.x, p.y);
  
  float displacement = computeD();
  PVector pointto = pixelScale(displacement, 0);
  line(0,0, pointto.x, pointto.y);
  
  
  float velocity = computeV();
  PVector vp = pixelScale(0, velocity);
  line(0,0, vp.x, vp.y);
   pop();
}


void displayCircle() {
  stroke(white);
  strokeWeight(2);
  PVector p = pixelPositions((xLength[1] - xLength[0])/1.5,0);
  push();
  translate(p.x, p.y);
  
  float displacement = computeD();
  PVector pointto = pixelScale(displacement, 0);
  float velocity = computeV();
  PVector vp = pixelScale(0, velocity);
  pPoints.add(new PVector(vp.x + pointto.x, pointto.y + vp.y));
  line(0,0, pointto.x + vp.x, pointto.y + vp.y);
  for (int i = 0; i < pPoints.size(); i++) {
    point(pPoints.get(i).x, pPoints.get(i).y); 
  }
   pop();
}

PVector pixelScale(float x, float y) {
   float xPix = x*width/(xLength[1] - xLength[0]);
   float yPix = y*height/(yLength[1] - yLength[0]);
   return new PVector(xPix, yPix);
}
