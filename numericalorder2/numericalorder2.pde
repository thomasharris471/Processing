float dx = .01;
float m = -50;

float yPrev;
float yCur;

float y2Prev;
float y2Cur;

ArrayList<Float> graph;

void setup() {
  size(600,600);
  yCur = 100;
  yPrev = 90;
  
  y2Cur = 10;
  y2Prev = 9;
  graph = new ArrayList<Float>();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  scale(1,-1);
  graph.add(yCur);
  displayGraph();
  displayAxis();
  displayBall();
  displayBall2();
}

void displayGraph() {
  for (int i = 0; i < graph.size(); i++) {
     point(graph.size() - i, graph.get(i)); 
  }
}

void displayAxis() {
  stroke(255,0,0);
  line(-width, 0, width, 0);
  line(0, -height, 0, height);
}

void displayBall() {
  stroke(255,255,255,255);
  ellipse(0, yCur, 10, 10);
  float hold = yCur;
  yCur = update(yCur, yPrev);
  yPrev = hold;
}

void displayBall2() {
  stroke(255,255,255,255);
  ellipse(0, y2Cur, 10, 10);
  float hold = y2Cur;
  y2Cur = update(y2Cur, y2Prev);
  y2Prev = hold;
}

float update(float yCur, float yPrev) {
  return m*yCur*dx*dx + 2*yCur - yPrev; 
}
