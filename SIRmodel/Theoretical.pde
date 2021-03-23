float beta;
float gamma;
float alpha;


ArrayList<Float> theoSus;
ArrayList<Float> theoInf;
ArrayList<Float> theoRec;

ArrayList<Float> error;

float total;

void determineInfectTerms() {
   
   float randomnessScalar = .34*1;
  
  float dynamicArea =  randomnessScalar*2*infectionRadius*maxTravelSpeed*unitTime;
  float staticArea =  PI*pow(infectionRadius,2);
  float areaPerPerson = pow(worldSize,2)/total;
  if (staticArea < areaPerPerson ) {
    staticArea = 0;  
  }
  float density = (dynamicArea/pow(worldSize,2)) + staticArea/pow(worldSize,2);
  float guessTerm = density;
  beta = guessTerm*chanceOfInfection/100;
}

void initializeTheos() {
  
  total = s0 + i0 + r0;
  
  determineInfectTerms();
  
  
 
  
  
  gamma = chanceOfRecovery/100;
  
  theoSus = new ArrayList<Float>();
  theoInf = new ArrayList<Float>();
  theoRec = new ArrayList<Float>();
  error = new ArrayList<Float>();
  
  
  
  
  theoSus.add(s0);
  theoInf.add(i0);
  theoRec.add(r0);
  
  
}

float getError(float a, float b) {
  float num = abs(a - b);
  if (a == 0 && b == 0) {
    return 0; 
  } else {
    float max = max(abs(a), abs(b)); 
    return num/max;
  }
}

void updateTheos() {
  float cS = theoSus.get(theoSus.size()-1);
  float cI = theoInf.get(theoInf.size()-1);
  float cR = theoRec.get(theoRec.size()-1);
  float ds = -beta*cI*cS*dt;
  float di = (beta*cI*cS - gamma*cI)*dt;
  float dr = gamma*cI*dt;
  theoSus.add(cS + ds);
  theoInf.add(cI + di);
  theoRec.add(cR + dr);
}
void displayTheos() {
    push();
  scale(1,-1);
  translate(0, -height);
  displayPlotQ(theoSus, width, panelHeight, theosusColor); 
  displayPlotQ(theoInf, width, panelHeight, theoinfColor); 
  displayPlotQ(theoRec, width, panelHeight, theorecColor); 
  pop();
}

void updateError() {
  
}

void displayError() {
  
}



color theosusColor = color(255,255,51);
color theoinfColor = color(0,102,204);
color theorecColor = color(204,0,102);
