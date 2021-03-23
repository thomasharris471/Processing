

int n = 1000;
float dt;

float scl = 150;

float p = 0;


void setup() {
  size(600,600,P3D);
  dt = (float)2*PI/n;

}

void draw() {
  background(0);
  lights();

  
  
  translate(width/2,height/2);
  rotateX((float)2*PI*frameCount/100);
 //rotateX(PI/4);
  scale(1,-1);
 // displayBaseCircle();
  displayTorus();
  displayFourier();
 // float holder = p;
 // p = -p;
 // displayFourier();
 // p = holder;
  
  p = p + .01;
}

void displayBaseCircle() {
  stroke(255,255,255,255);
  strokeWeight(1);
  for (int i = 0; i < n; i++) {
     line(scl*cos((float)i*dt), scl*sin((float)i*dt), scl*cos((float)(i+1)*dt), scl*sin((float)(i+1)*dt));
  }
}

void displayTorus() {
   for (int i = 0; i < n; i = i + 5) {
     pushMatrix();
       stroke(0,255,0,100);
    strokeWeight(1);
    noFill();
     translate(scl*cos((float)i*dt), scl*sin((float)i*dt));
     rotateZ((float)i*dt);
     rotateX(PI/2);
     ellipse(0,0,scl,scl);
     popMatrix();
  }
}

void displayFourier() {

  for (int i = 0; i < n; i ++) {
     pushMatrix();
     translate(scl*cos((float)i*dt), scl*sin((float)i*dt));
     rotateZ((float)i*dt);
     rotateX(PI/2);
     stroke(255,0,0,255);
     strokeWeight(10);
 //   line(scl*cos((float)p*i*dt)/2, scl*sin((float)p*i*dt)/2, scl*cos((float)p*(i+1)*dt)/2, scl*sin((float)p*(i+1)*dt)/2);
    ellipse(scl*cos((float)p*i*dt)/2, scl*sin((float)p*i*dt)/2, .5,.5);
     popMatrix();
  }
}
  
