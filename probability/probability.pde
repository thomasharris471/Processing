double probOfBoy = 0.5;
int numberOfPeople = 2;

int stepsPerFrame = 10000;

double numberOfGirls;
double numberOfBoys;

double iterations;

int m = 1000000000;
int trials;
ArrayList<Integer> choices;

boolean repeated;

void setup() {
//  numberOfGirls= 0;
//  numberOfBoys = 0;
//  iterations = 0;
choices = new ArrayList<Integer>();
trials = 0;
repeated = false;
}

void draw() {
  while(!repeated) {
    trials++;
    int r = int(random(1, m));
    if (choices.contains(r)) {
      println(m + " , " + trials);
      repeated = true;
    } else {
      choices.add(r); 
    }
  }
  if (repeated) {
    m++;
    choices = new ArrayList<Integer>();
    repeated = false;
    trials = 0;
  }
  /*
  numberOfGirls= 0;
  numberOfBoys = 0;
  for (int i = 0; i < numberOfPeople; i++) {
    while(Math.random() <= probOfBoy) {
      numberOfGirls++; 
    }
    numberOfBoys++;
  }
  iterations++;
  System.out.println(1-numberOfBoys/numberOfGirls);
  */
  
}
