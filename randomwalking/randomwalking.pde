int numberOfParticles = 1000000;



int walkStep = 1;

int iterations;

ArrayList<Integer> particles; 




void setup() {
  particles = new ArrayList<Integer>();
  for (int i = 0; i < numberOfParticles; i++) {
    particles.add(i, new Integer(0)); 
  }
  iterations = 0;
  
  size(1280, 720);
}

void draw() {
  background(0);
  translate(width/2, height);
  scale(1,-1);
  iterations++;
  displayParticles();
  displayMean();
  displayStandardDeviation();

  for (int i = 0; i < particles.size(); i++) {
     int position = particles.get(i);
     double step = 3*Math.random();
     if (step < 1) {
       position = position - walkStep; 
     } else if ( step < 2) {
       position = position + walkStep; 
     } else {
      // position = position;
     }
     particles.set(i, position);
  }
}

void displayStandardDeviation() {
  int sum = 0; 
  for (int i = 0; i < particles.size(); i++) {
    sum = sum + particles.get(i); 
  }
  float mean = (float) sum / particles.size();
  float term = 0;
  for (int i = 0; i < particles.size(); i++) {
     term = term + pow((mean - particles.get(i)),2);
  }
  float stdDev;
//  if (particles.size() == 1) {
//    stdDev = 0; 
//  } else {
    stdDev = sqrt(term/(particles.size() )); 
//  }
  stroke(255,9,255,255);
  
  line(5*(mean + stdDev), 0, 5*(mean + stdDev), height);
  line(5*(mean - stdDev), 0, 5*(mean - stdDev), height);
}

void displayMean() {
  int sum = 0; 
  for (int i = 0; i < particles.size(); i++) {
    sum = sum + particles.get(i); 
  }
  float mean = (float) sum / particles.size();
  stroke(255,255,0,255);
  line(5*mean, 0, 5*mean, height);
}

void displayParticles() {
  ArrayList<Integer> positions = new ArrayList<Integer>(); 
  for (int i = 0; i < 2*iterations-1; i++) {
     positions.add(i, 0);
  }
  for (int i = 0; i < particles.size(); i++) {
    int currPos = particles.get(i);
    int currentNumThere = positions.get(currPos+iterations-1);
    positions.set(currPos+iterations-1, currentNumThere + 1);
  }
  
  int max = positions.get(0);
  for (int i = 0; i < positions.size(); i++) {
   if(positions.get(i) > max) {
     max = positions.get(i); 
   }
  }
  
  for (int i = 0; i < positions.size(); i++) {
    float h = (float) height*positions.get(i) / particles.size();
    stroke(255,255,255,255);
    line(5*(i - iterations), 0, 5*(i - iterations), h);
    line(-width, 0, width, 0);
  }
  
}
