void setup() {
  
  background(0);
  stroke(255);
  size(600,600);
  translate(width/2, height/2);
  scale(1,-1);
  scale(.3,1);
  
  //println(10*(float)taylor(50,7));
//  println(taylor(1000,PI/2));
  
//   println(taylorSeries(f,0,10,.01).apply(PI));
 // println(derivative(g, .01, 10).apply(0)/factorial(10));
 // println(derivative(f, .01, 10).apply(5)/factorial(10));
//println(derivative(f, .9, 31).apply(PI/2));
  println(taylorC(50,2*PI));
}

int index = 1;

void draw() {
  if (frameCount % 10 == 0) {
    translate(width/2, height/2);
    scale(.3,-1);
    background(0);
    for (int i = 0; i < 1000; i++) {
    //  line(i,10*(float)taylorS(index,(float)i/20), i+1, 10*(float)taylorS(index,(float) i/20 + .05));
    //  line(-i,10*(float)taylorS(index,(float)-i/20), -i-1, 10*(float)taylorS(index,(float) -i/20 - .05));
      
      line(i,10*(float)taylorC(index,(float)i*PI/20), i+1, 10*(float)taylorC(index,(float) i/20*PI + .05*PI));
      line(-i,10*(float)taylorC(index,(float)-i*PI/20), -i-1, 10*(float)taylorC(index,(float) -i/20*PI - .05*PI));
    }
    index++;
  }
}

float taylorC(int n, float x) {
  double val = 1;
  for (int k = 1; k < n; k++) {
    float kj = (float)k;
    val = val*(1 + (double)(-1)*x*x/((2*kj-1)*(2*kj)));
   // println(val);
  }
  return (float)val;
}

float taylorS(int n, float x) {
  double val = x;
  for (int k = 1; k < n; k++) {
    float kj = (float)k;
    val = val*(1 + (float)(-1)*x*x/((2*kj+1)*(2*kj)));
   // println(val);
  }
  return (float)val;
}
