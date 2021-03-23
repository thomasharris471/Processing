PVector[][] positionArray;
float wid;
float hit;
float maxsize;
float time;

void setup() {
  size(1080,720);
  background(backgroundColor);
  wid = (float)width;
  hit = (float)height;
  maxsize = max(wid, hit)/2;
  positionArray = new PVector[ceil(numberOfParticles)][ceil(numberOfParticles)];
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      positionArray[i][j] = new PVector(-2*xScale + i*4*xScale/numberOfParticles, -2*xScale + j*4*xScale/numberOfParticles);
    }
  }
}

void draw() {
  time = frameCount; 
  fill(backgroundColor,backgroundOpacity);
  rect(0,0,wid,hit);
  translate(wid/2 - center[0]*wid/xScale/2, hit/2 + center[1]*wid/xScale/2);
  scale(1,-1);
  displayAxis();
  updatePositions();
  
}
  
void displayAxis() {
  stroke(axisColor,axisOpacity);
  line(-4*wid,0,4*wid,0);
  line(0,-4*hit,0,4*hit);
  
   pushMatrix();
   scale(1,-1);
   float axistextSize = wid/40;
   textSize(axistextSize);
   fill(axisColor,axisOpacity);
   textAlign(CENTER, CENTER);
   text(oneDec(xScale/2), wid/4, 1.5*axistextSize);
   ellipse(wid/4, 0, 10, 10);
   text(oneDec(xScale/2), -1.5*axistextSize, -wid/4);
   ellipse(0, -wid/4, 10, 10);
   popMatrix();
}

String oneDec(float num) {
  return str(float(int(num*100))/100);
}
  
  
void updatePositions() {
  PVector cVec;
  PVector nVec = new PVector();
  stroke(strokeColor,strokeOpacity);
  strokeWeight(weightOfStroke);
  for (int i = 0; i < positionArray.length; i++) {
    for (int j = 0; j < positionArray[i].length; j++) {
      cVec = positionArray[i][j];
      if(randomMode) {
        nVec.x = cVec.x + deltaT*xPrimeRandom(cVec.x, cVec.y, time);
        nVec.y = cVec.y + deltaT*yPrimeRandom(cVec.x, cVec.y, time);
      } else {
        nVec.x = cVec.x + deltaT*xPrime(cVec.x, cVec.y, time);
        nVec.y = cVec.y + deltaT*yPrime(cVec.x, cVec.y, time);
      }
      line(maxsize/xScale*cVec.x, maxsize/xScale*cVec.y, maxsize/xScale*(nVec.x), maxsize/xScale*(nVec.y));
      cVec.x = nVec.x;
      cVec.y = nVec.y;
    }
  }
  
}
