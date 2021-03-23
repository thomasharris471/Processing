color white = color(255,255,255);
color green = color(45,245,0);
color purple = color(162,24,170);
color backgroundColor = color(10,10,10);


float axisstrokeWeight = 2;
float plotstrokeWeight = 2;

float xAxis;
float yAxis;

float[] domain = {0,10};

float[] range = {-10,10};

void createAxis() {
  stroke(purple);
  strokeWeight(axisstrokeWeight);
  line(-width/2, xAxis, width/2, xAxis);
  line(yAxis, -height/2, yAxis, height/2);
}

void createGraph() {
 stroke(white);
 strokeWeight(plotstrokeWeight);
  for (int i = 0; i < width-1; i++) {
    float x0 = map(i, 0, width-1, -width/2, width/2);
    float x1 = map(i+1, 0, width-1, -width/2, width/2);
    line(x0,currentPhi[i],x1,currentPhi[i+1]);
  }
}
