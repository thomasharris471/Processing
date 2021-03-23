
ArrayList<Integer> totalSus;
ArrayList<Integer> totalInf;
ArrayList<Integer> totalRec;

ArrayList<Person> allPeople;



ArrayList<Person> sus;
ArrayList<Person> inf;
ArrayList<Person> rec;

ArrayList<Person> infectedHolder;

float panelHeight;

float totalPeople;

float timeInterval;


float totalAverageSpeed;
float numberOfCounts;

void setup() {
  totalAverageSpeed = 0;
  numberOfCounts = 0;
  
  size(1280, 850);
  

  
  totalPeople = s0 + i0 + r0;
  
  panelHeight = height*panelPercentageSize;
  sus = new ArrayList<Person>();
  inf = new ArrayList<Person>();
  rec = new ArrayList<Person>();
  for (int i = 0; i < s0; i++) {
    float x = random(0, worldSize);
    float y = random(0, worldSize);
    sus.add(new Person(x, y, 0));
  }
  for (int i = 0; i < i0; i++) {
    float x = random(0, worldSize);
    float y = random(0, worldSize);
    inf.add(new Person(x, y, 1));
  }
  for (int i = 0; i < r0; i++) {
    float x = random(0, worldSize);
    float y = random(0, worldSize);
    rec.add(new Person(x, y, 2));
  }
  background(0);
  
  totalSus = new ArrayList<Integer>();
  totalInf = new ArrayList<Integer>();
  totalRec = new ArrayList<Integer>();
  
  totalSus.add(sus.size());
  totalInf.add(inf.size());
  totalRec.add(rec.size());
  
  
  allPeople = new ArrayList<Person>();
  
  for (int i = 0; i < sus.size(); i++) {
    allPeople.add(sus.get(i)); 
  }
  for (int i = 0; i < inf.size(); i++) {
    allPeople.add(inf.get(i)); 
  }
  for (int i = 0; i < rec.size(); i++) {
    allPeople.add(rec.get(i)); 
  }
  
  timeInterval = 0;
  initializeTheos();
}


void draw() {
 
  fill(0,0,0,255);
  rect(0,0,width,height);
  makePlots();
  rect(0,0,width,height-panelHeight);
  displayPeople();
  
  
  for (int i = 0; i < stepsPerFrame; i++) {
    movePeople();
    infectPeople();
    recoverPeople();
    updateTheos();
    updatePopTracker();
    displayTheos();
    
  //  updatetotalContacts();
    if (timeInterval >= unitTime) {
   //   println(computeAverageContacts());
    //  clearContacts();
   //  
      totalAverageSpeed = (totalAverageSpeed*numberOfCounts + getAverageDistance()/maxTravelSpeed)/(numberOfCounts +1 );
      numberOfCounts++;
     // println(totalAverageSpeed);
      savePosition();
      timeInterval = 0;
    }
    timeInterval = timeInterval + dt;
    updateNoiseCoordinates();
    
  }
  

  
  
}

float getAverageDistance() {
  float totalDistance = 0;
  for (int i = 0; i < allPeople.size(); i++) {
    Person p = allPeople.get(i);
    float ox = p.xHolder;
    float oy = p.yHolder;
    float x= p.x;
    float y = p.y;
    totalDistance = totalDistance + sqrt(pow(x-ox,2) + pow(y-oy,2));
  }
  return totalDistance / allPeople.size();
}


void savePosition() {
   for (int i = 0; i < allPeople.size(); i++) {
    Person p = allPeople.get(i);
    p.xHolder = p.x;
    p.yHolder = p.y;
  }
}

void updateNoiseCoordinates() {
  for (int i = 0; i < allPeople.size(); i++) {
    Person p = allPeople.get(i);
    p.xNoise = p.xNoise + dt;
    p.yNoise = p.yNoise + dt;
  }
}

float computeAverageContacts() {
  float totalContacts = 0;
  for (int i = 0; i < allPeople.size(); i++) {
    totalContacts = totalContacts + allPeople.get(i).contacts.size();
  }
  //subtract off self contacts
  totalContacts = totalContacts - allPeople.size();
  return (float) totalContacts/allPeople.size();
}

void clearContacts() {
  for (int i = 0; i < allPeople.size(); i++) {
    allPeople.get(i).contacts.clear();
  }
}



void updatetotalContacts() {
   for (int i = 0; i < allPeople.size(); i++) {
     Person p1 = allPeople.get(i);
     for (int j = 0; j < allPeople.size(); j++) {
       Person p2 = allPeople.get(j);
       if (distance(p1, p2) < infectionRadius && !p1.hasContacted(p2)) {
         p1.contacts.add(p2);
       }
     }
   }
}


void makePlots() {
  push();
  scale(1,-1);
  translate(0, -height);
  displayPlot(totalSus, width, panelHeight, susColor); 
  displayPlot(totalInf, width, panelHeight, infColor); 
  displayPlot(totalRec, width, panelHeight, recColor); 
  pop();
}

void updatePopTracker() {
  totalSus.add(sus.size());
  totalInf.add(inf.size());
  totalRec.add(rec.size());
}

float distance(Person p1, Person p2) {
  float x1 = p1.x;
  float x2 = p2.x;
  float y1 = p1.y;
  float y2 = p2.y;
  
  float dx = abs(x2 - x1);
  float dy = abs(y2 - y1);
  if (dx > worldSize/2) {
    dx = worldSize - dx; 
  }
  if (dy > worldSize/2) {
    dy = worldSize - dy; 
  }
  
  return sqrt(dx*dx + dy*dy);
}

void infectPeople() {
  for (int i = 0; i < inf.size(); i++) {
    Person infected = inf.get(i);
    for (int j = 0; j < sus.size(); j++) {
       Person susceptible = sus.get(j);
       float dist = distance(infected, susceptible);
       if (dist < infectionRadius) {
         float diceRoll = random(0, 100);
         if (diceRoll <= chanceOfInfection*dt) {
           susceptible.state = 1;
         }
         susceptible.hadContact = true;
       }
    }
  }
  for (int i = 0; i < sus.size(); i++) {
    Person p = sus.get(i);
    if (p.state == 1) {
      sus.remove(i);
      inf.add(p);
    }
  }
}

void recoverPeople() {
  for (int i = 0; i < inf.size(); i++) {
    Person p = inf.get(i);
    float diceRoll = random(0,100);
    if (diceRoll < chanceOfRecovery*dt) {
      p.state = 2; 
    }
  }
  for (int i = 0; i < inf.size(); i++) {
    Person p = inf.get(i);
    if (p.state == 2) {
      inf.remove(i);
      rec.add(p);
    }
  }
}

void checkIfOffTorus(Person p) {
  if (p.x < 0) {
    p.x = p.x + worldSize; 
  }
  if (p.x > worldSize) {
    p.x = p.x - worldSize; 
  }
  if (p.y < 0) {
    p.y = p.y + worldSize; 
  }
  if (p.y > worldSize) {
    p.y = p.y - worldSize; 
  }
  
}

void movePeople() {

  subMovePeople(sus);
  subMovePeople(inf);
  subMovePeople(rec);
}

void subMovePeople(ArrayList<Person> peeps) {
    for (int i = 0; i < peeps.size(); i++) {
    
    Person p = peeps.get(i);
    float xN = p.xNoise;
    float yN = p.yNoise;
    float dx = (noise(xN)-.5)* maxTravelSpeed*dt;
    float dy = (noise(yN)-.5)* maxTravelSpeed*dt;
    p.x = p.x + dx;
    p.y = p.y + dy;
    checkIfOffTorus(p);
  }
}

void displayPeople() {
  noStroke();
  subdisplayPeople(sus);
  subdisplayPeople(inf);
  subdisplayPeople(rec);
}

void subdisplayPeople(ArrayList<Person> peeps) {
  for (int i = 0; i < peeps.size(); i++) {
    Person p = peeps.get(i);
    if (p.state == 0) {
      if (p.hadContact && displayContaced) {
      fill(contactColor);
    } else {
        fill(susColor); 
    } 
  }else if (p.state == 1) { 
      if (drawInfectionRadius) {
        fill(infColor, infectionRadiusopacity);
        displayEllipse(p.x, p.y, infectionRadius, infectionRadius);
      }
       fill(infColor);
    } else if (p.state == 2) {
       fill(recColor);
    } else {
      fill(255,255,0); 
    }
    displayEllipse(p.x, p.y, personSize, personSize);
  }
}

void displayEllipse(float x, float y, float dx, float dy) {
  PVector pPos = pixelScale(x,y);
  PVector pD = pixelScale(dx, dy);
  ellipse(pPos.x, pPos.y, pD.x, pD.y);
}


PVector pixelScale(float x, float y) {
   float xPix = x*(width)/(worldSize);
   float yPix = y*(height-panelHeight)/(worldSize);
   return new PVector(xPix, yPix);
}
