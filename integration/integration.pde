float xAxis;
float yAxis;

float[] values;

void setup() {
  size(600,600);
  smooth(6);
  xAxis = map(0, range[0], range[1], -height/2, height/2);
  yAxis = map(0, domain[0], domain[1], -width/2, width/2);
  values = new float[width];
  for (int i = 0; i < width; i++) {
    double inputx0 = map(i, 0, width-1, domain[0], domain[1]);
    values[i] = map((float) f.apply(inputx0), range[0], range[1], -height/2, height/2);
  }
}

void draw() {
  background(backgroundColor);
  translate(width/2,height/2);
  scale(1,-1);
  integralBoxes();
  
  createAxis();
  createGraph();


  rectWidth = 1.1 + cos((float) frameCount/100);
  if (frameCount % 100 == 0){ 
    partitions++;
  }
}

void integralBoxes() {
  fill(integralColor);
  stroke(integralBoundaryColor);
  noStroke();
//  int pixelJump = ceil(map(rectWidth + domain[0], domain[0], domain[1], 0, width));
  float pixelJump = (float) width / pow(2, partitions);
  for (float i = 0; i < width; i = i + pixelJump) {
    float x0 = map(i, 0, width-1, -width/2, width/2);
    rect(x0 - (float)pixelJump/2,xAxis, pixelJump, values[floor(i)]);
  }
}

void createGraph() {
 stroke(plotColor);
 strokeWeight(plotstrokeWeight);
  for (int i = 0; i < width-1; i++) {
    float x0 = map(i, 0, width-1, -width/2, width/2);
    float x1 = map(i+1, 0, width-1, -width/2, width/2);
    line(x0,values[i],x1,values[i+1]);
  }
}

void createAxis() {
  stroke(axisColor);
  strokeWeight(axisstrokeWeight);
  line(-width/2, xAxis, width/2, xAxis);
  line(yAxis, -height/2, yAxis, height/2);
}
