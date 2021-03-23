float radius = 1;
int n = 1000;

float dt;

float scl;

float power = 2;
float step = 0;

void setup() {
  size(600,600);
  background(0);
  dt = (float)2*PI/n;

  scl = width/4;
}

void draw() {
  background(0);
  translate(width/2, height/2);
  scale(1,-1);

  displayCircle();
  displayFourier();
  displayStep();
  step++;

}

void displayStep() {
    stroke(255,255,255,255);
  strokeWeight(1.3);
  ellipse(scl*cos((float)step*dt), scl*sin((float)step*dt), 5, 5);
}


void displayFourier() {
  if (power != 0) {
    int modn = abs(ceil(n*10*power));
    float moddt = (float)2*PI/modn;;
    stroke(255,0,0,255);
    strokeWeight(1);
    for (int i = 0; i < abs(step*10*power); i++) {
      pushMatrix();
      translate(scl*cos((float)i*moddt), scl*sin((float)i*moddt));
      rotate((float)i*moddt);
      line(scl*cos((float)power*i*moddt), scl*sin((float)power*i*moddt), scl*cos((float)power*(i+1)*moddt), scl*sin((float)power*(i+1)*moddt));
      popMatrix();
    }
    
      pushMatrix();
      stroke(0,255,0,255);
      strokeWeight(5);
      translate(scl*cos((float)abs(step*10*power)*moddt), scl*sin((float)abs(step*10*power)*moddt));
      rotate((float)abs(step*10*power)*moddt);
      ellipse(scl*cos((float)power*abs(step*10*power)*moddt), scl*sin((float)power*abs(step*10*power)*moddt), 10, 10);
      popMatrix();
  } else {
    int modn = abs(ceil(n*10));
    float moddt = (float)2*PI/modn;;
    stroke(255,0,0,255);
    strokeWeight(1);
    for (int i = 0; i < abs(step*10); i++) {
      pushMatrix();
      translate(scl*cos((float)i*moddt), scl*sin((float)i*moddt));
      rotate((float)i*moddt);
      line(scl*cos((float)power*i*moddt), scl*sin((float)power*i*moddt), scl*cos((float)power*(i+1)*moddt), scl*sin((float)power*(i+1)*moddt));
      popMatrix();
    }
    
      pushMatrix();
      stroke(0,255,0,255);
      strokeWeight(5);
      translate(scl*cos((float)abs(step*10)*moddt), scl*sin((float)abs(step*10)*moddt));
      rotate((float)abs(step*10)*moddt);
      ellipse(scl, 0, 10, 10);
      popMatrix();
  }
    
  
}

void displayCircle() {
  stroke(255,255,255,255);
  strokeWeight(1.3);
  for (int i = 0; i < step; i++) {
     line(scl*cos((float)i*dt), scl*sin((float)i*dt), scl*cos((float)(i+1)*dt), scl*sin((float)(i+1)*dt));
  }
}
