
float[] currentPhi;
float[] nextPhi;


void setup() {
  size(1080,720);
  smooth(6);

  xAxis = map(0, range[0], range[1], -height/2, height/2);
  yAxis = map(0, domain[0], domain[1], -width/2, width/2);
  
  currentPhi = new float[width];
  nextPhi = new float[width];
  
 createInitialPhi();
  
}

void draw() {
  background(backgroundColor);
  translate(width/2,height/2);
  scale(1,-1);
  createAxis();
  createGraph();
  if (frameCount % 50 ==0 ) {
    createNextPhi();
  }
}

void createInitialPhi() {
  for (int i = 0; i < width; i++) {
    currentPhi[i] = map((float) y0, range[0], range[1], -height/2, height/2);
  }
}

//create next function algorithm
//phi_{k+1}(t) = y_0 + \int_{t_0}^{t} f(s, \phi_k(s)) dx
//phi_{0}(t) := y_0

void createNextPhi() {
  float dt = (domain[1] - domain[0])/width;
  nextPhi[0] = map((float) y0, range[0], range[1], -height/2, height/2);
  for (int j = 1; j < width; j ++) {
     float time = map(j, 0, width-1, domain[0], domain[1]);
     float value = map((float) currentPhi[j], -height/2, height/2, range[0], range[1]);
     nextPhi[j] = nextPhi[j-1] + map((float) f(time, value), range[0], range[1], -height/2, height/2)*dt;
  }
  for (int i = 0; i < width; i++) {
    currentPhi[i] = nextPhi[i];
  }
}
