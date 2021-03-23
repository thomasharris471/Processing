

// spring data

float currentDisplacement;
float previousDisplacement;


//time step
float currentTime;

float dt = .01;

//steps per frame




color white = color(255,255,255);
color green = color(45,245,0);
color purple = color(162,24,170);
color backgroundColor = color(10,10,10);


ArrayList<Float> graph;


void setup() {
  size(1080,720);
  frameRate(2);
  currentDisplacement = initialDisplacement;
  previousDisplacement = initialDisplacement - initialVelocity*dt;
  graph = new ArrayList<Float>();
  currentTime = 0;
  frameRate(30);
}

void draw() {
  background(backgroundColor);
  translate(width-width/4, height/2);
  scale(1,-1);
  displayAxis();

  displayMassSpring();
    updateGraph();
  displayDifferentialEquation();
  updateSpring();
//  displayForce();
}

void displayForce() {
  line(150,0,150,100*sin(2*currentTime));
  line(250,0,250,100*sin(omega*currentTime));
}

void keyPressed() {
  if (key == 'a') {
    omega = omega - 0.1; 
  } else if (key == 's') {
    omega = omega + 0.1;
  }
}


void displayMassSpring() {
  fill(255,255,255,255);
  stroke(255,255,255,255);
  rectMode(CENTER);
    textSize(32);
    textAlign(RIGHT, TOP);
  //mass
  rect(0, currentDisplacement, 200, 50);

  //base
  float baseLocation = -height/2;
  rect(0,baseLocation,300,20);
  
  //spring
  pushMatrix();
  translate(-50, 0);
  int numberOfFolds = 10;
  float staightLength = 50;
  float foldLength = 100;
  
  float theta = asin((abs(currentDisplacement - baseLocation) - 2*staightLength)/((numberOfFolds + 1)*foldLength));
  float currentX = 0;
  float currentY = baseLocation;
  line(currentX, currentY,0,currentY + staightLength);
  currentY = currentY + staightLength;
  line(currentX, currentY, currentX + cos(theta)*foldLength/2, currentY + sin(theta)*foldLength/2);  
  currentX = currentX + cos(theta)*foldLength/2;
  currentY = currentY + sin(theta)*foldLength/2;
  for (int i = 0; i < numberOfFolds; i++) {
    line(currentX, currentY, currentX + pow(-1, i+1)*cos(theta)*foldLength, currentY + sin(theta)*foldLength); 
    currentX = currentX + pow(-1, i+1)*cos(theta)*foldLength;
    currentY = currentY + sin(theta)*foldLength;
  }
  line(currentX, currentY, currentX + pow(-1, numberOfFolds+1)*cos(theta)*foldLength/2, currentY + sin(theta)*foldLength/2);  
  currentX = currentX +  pow(-1, numberOfFolds+1)*cos(theta)*foldLength/2;
  currentY = currentY + sin(theta)*foldLength/2;
  line(currentX, currentY,0,currentY + staightLength);
  scale(1,-1);
  text("k = " + k, currentX-100, -baseLocation/2+50);
  
  popMatrix();
  //damper
   pushMatrix();
  translate(50, 0);
  currentX = 0;
  currentY = baseLocation;
  line(currentX, currentY, currentX, currentY  + abs(baseLocation)/10);
  currentX = currentX;
  currentY = currentY  + abs(baseLocation)/10;
  line(currentX - 25, currentY, currentX + 25, currentY);
  line(currentX - 25, currentY, currentX - 25, currentY+250);
  line(currentX + 25, currentY, currentX + 25, currentY+250);
  
  line(currentX, currentDisplacement, currentX, currentDisplacement - 150);
  currentY = currentDisplacement - 150;
  line(currentX - 15, currentY, currentX + 15, currentY);
  scale(1,-1);

  text("b = " + b, currentX+200, -baseLocation/2+50);
  popMatrix();
  pushMatrix();
  scale(1,-1);
  fill(backgroundColor);
  textAlign(CENTER, CENTER);
  text("m = " + m, 0, -currentDisplacement);
  popMatrix();
  fill(white);
  
}









void displayAxis() {
  stroke(purple);
  fill(white);
  line(-width, 0, width, 0);
  line(0, -height, 0, height);

  textSize(32);
  pushMatrix();
  scale(1,-1);
  textAlign(RIGHT, TOP);
  text("time", -width/2,0);
  text("y(t)", -10, -height/4);
  textAlign(LEFT, TOP);
  textSize(20);
  fill(purple);
  text(360, 10, -height/2);
  text(90, 10, -height/8);
  text(180, 10, -2*height/8);
  text(270, 10, -3*height/8);
  popMatrix();
}

void updateGraph() {
  stroke(green);
  graph.add(currentDisplacement);
  pushMatrix();
  scale(-1,1);
  for (int i = 0; i < graph.size(); i++) {
     point(graph.size() - i, graph.get(i)); 
  }
  popMatrix();
}



void updateSpring() {
  for (int i = 0; i < stepsPerFrame; i++) {
    float denominator = b*dt + 2*m;
    float num1 = (-2*dt*dt*k+4*m)*currentDisplacement;
    float num2 = (b*dt - 2*m)*previousDisplacement;
    float num3 = 2*dt*dt*f(currentTime);
    previousDisplacement = currentDisplacement;
    currentDisplacement = (num1 + num2 + num3)/denominator;
    currentTime = currentTime + dt;
  }
}

void displayDifferentialEquation() {
   fill(255,255,255,255);
   pushMatrix();
   textAlign(LEFT, BOTTOM);
   scale(1,-1);
   textSize(32);
   text(m + "y'' + " + b + "y' + " + k + "y" + " = " + nf(f(currentTime),0,2), -width+width/4, -(float)height/2 + (float)height/12);
   textSize(20);
   text("y(0)  = " + initialDisplacement, -width/2, -(float)height/2 + (float)height/12 + 32);
   text("y'(0)  = " + initialVelocity, -width/2, -(float)height/2 + (float)height/12 + 64);
   text("frequency  = " + omega, -width/2, -(float)height/2 + (float)height/12 + 64+32);
   popMatrix();
}
