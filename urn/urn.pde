double baseB = 1;
double baseR = 1;

double c = 2;

int iterations = 10000;
int numberOfUrns = 100000;

int total = (int)(baseB + baseR);

double[] X;
double[] b;
double[] r;

void setup() {
  X = new double[numberOfUrns];
  b = new double[numberOfUrns];
  r = new double[numberOfUrns];
  for (int i = 0; i < numberOfUrns; i++) {
    b[i] = baseB;
    r[i] = baseR;
    X[i] = b[i]/(b[i] + r[i]);
  }
  
  size(1280, 720);
}

void draw() {
  for (int i = 0; i < numberOfUrns; i++) {
    if (Math.random() <= X[i]) {
      b[i] = b[i]+c;
    } else {
      r[i] = r[i]+c;
    }
    X[i] = b[i]/(b[i] + r[i]);
  }
  total = total + (int)c;
  int[] blackCount = new int[total];
  for (int i = 0; i < blackCount.length; i++) {
    blackCount[i] = 0; 
  }
  for (int i = 0; i < b.length; i++) {
    blackCount[(int)b[i]]++; 
  }
  double[] orderedRatio = new double[total];
  for (int i = 0; i < total; i++) {
    orderedRatio[i] = (double) blackCount[i]/total; 
  }
  
  background(0);
  translate(width/4, 4*height/5);
  scale(1, -1);
  
  stroke(255, 255, 255, 255);
  for (int i = 0; i < total; i++) {
    float pos = map((float)i, 0, total, 0, 500);
    float h = 100*(float)orderedRatio[i];
    line(pos, 0, pos, h);
  }
  

}
