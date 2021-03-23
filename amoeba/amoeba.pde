
int a = 1;
double p = .7;
int rep = 3;
int diedout = 0;
int total = 0;

int r0 = 10;
int b0 = 1;
int c = 100;
int stepsPerFrame = 1;


int n = 0;

int b = b0;
int r = r0;

void setup() {
 // size(1280, 720);
}

void draw() {
//  background(0);
 // translate(width/2, height);
 // scale(1,-1);
  for (int i = 0; i < stepsPerFrame; i++) {
    double probability = (double) b/(b+r);
    System.out.println(probability);
    if (Math.random() <= probability) {
      b = b + c; 
      System.out.println(b);
    } else {
      r = r + c; 
    }
  }
  
  
//  System.out.println((float) b/(b+r));
  
  /*
  
  total++;
  a = 1;
  while(a > 0 && a < 100000) {
    int nua = 0;
    for (int i = 0; i < a; i++) {
      for (int j = 0; j < rep; j++) {
        if(Math.random() <= p) {
          nua++; 
        }
      }
    }
    a = nua;    
  }
  if(a == 0) {
    diedout++; 
  }
  
  */
  
  
 // System.out.println((float) diedout/total);
  
}
