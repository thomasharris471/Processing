ArrayList<Algorithm> algos;


void setup() {
  size(600, 600);
  frameRate(10);
  
  double y0 = Parameters.y0;
  Algorithm.setX(Parameters.x0);
  
  algos = new ArrayList<Algorithm>();
  algos.add(new Euler(y0));
 // algos.add(new RungeKutta(y0));
  
}

void draw() {
  translate(width/2, height/2);
  scale(1,-1);

  displayGraph();
  for (int i = 0; i < Parameters.stepsPerFrame; i++) {
    odeAlgos();
  }

}

void odeAlgos() {
  double x = Algorithm.x();
  double xn = Algorithm.nextX(Parameters.h);
  for (int i = 0; i < algos.size(); i++) {
    Algorithm a = algos.get(i); 
    stroke(a.getRed(), a.getGreen(), a.getBlue());
    double y = a.y();
    double yn = a.nextY(x, y, Parameters.h);
    a.setY(yn);
    displayLine(x, y, xn, yn);
  }
  Algorithm.setX(xn);
}


void displayGraph() {
  stroke(0);
  displayLine(Parameters.xRange[0], 0, Parameters.xRange[1], 0);
  displayLine(0, Parameters.yRange[0], 0, Parameters.yRange[1]);
}


/*

color rungeKuttaColor = color(255,255,255);


*/
//differential equation is y'  = f(x,y)












void displayArrow(double x0, double y0, double x1, double y1) {
 // displayLine(x0, y0, x1, y1); 
 // float theta = - (float)
  if (x1 - x0 == 0) {
    if (y1 - y0 >= 0) {
    //  theta =  
    }
  }
}


void displayLine(double x0, double y0, double x1, double y1) {
  PVector p0 = convert(x0, y0);
  PVector p1 = convert(x1, y1);
  line(p0.x, p0.y, p1.x, p1.y);
}

void displayPoint(double x, double y) {
  PVector pos = convert(x,y);
  point(pos.x, pos.y);
}

PVector convert(double x, double y) {
  float xVal = map((float)x, (float)Parameters.xRange[0], (float)Parameters.xRange[1], -width, width); 
  float yVal = map((float)y, (float)Parameters.yRange[0], (float)Parameters.yRange[1], -height, height); 
  return new PVector(xVal, yVal);
}
