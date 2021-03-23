

class Mass   {
  float m; 
  float currentPosition;
  float previousPosition;
  
  float currentForce;
  
  boolean isWall;
  
  float massLength;
  float massHeight;
  
  boolean hasLeftSpring;
  boolean hasRightSpring;
  Spring leftSpring;
  Spring rightSpring;
  
  ArrayList<Float> positions;
  
  
  Mass(float mass, float iP, float iV) {
    m = mass;
    currentPosition = iP;
    previousPosition = currentPosition - dt*iV;
    
    massLength = 15;
    massHeight = 8;
    isWall = false;
    
    hasLeftSpring = false;
    hasRightSpring = false;
    
    positions = new ArrayList<Float>();
  }
  
  Mass(float iP) {
    isWall = true;
    currentPosition = iP;
    
    hasLeftSpring = false;
    hasRightSpring = false;
    massLength=1;
    massHeight = 60;
  }
  
  void getForces() {
    float leftPart = 0;
    float rightPart = 0;
    if (hasLeftSpring) {
       leftPart = leftSpring.getForce(); 
    }
    if (hasRightSpring) {
      rightPart = rightSpring.getForce();
    }
    currentForce = leftPart - rightPart;
  }
  
  void updatePosition() {
    
    if (isWall) {
      //do nothing
    } else{
      float acceleraton = -1/m*(currentForce);
      float holder = acceleraton*dt*dt + 2*currentPosition - previousPosition;
      previousPosition = currentPosition;
      currentPosition = holder;
      positions.add(currentPosition);
      if (positions.size() > 12000) {
         positions.subList(0,4000).clear(); 
      }
    }
  }
  
}


class Spring {
  
  float k;
  
  float restLength;
  
  boolean hasLeftMass;
  boolean hasRightMass;
  Mass leftMass;
  Mass rightMass;
  
  int springFolds;
  float foldLength;
  float straightLength;
  
  Spring(float kC) {
     k = kC;
     restLength = 50;
     
     hasLeftMass = false;
     hasRightMass = false;
     
     springFolds = 9;
     foldLength = 20;
     straightLength = 15;
     
  }
  
  float getForce() {
    if(hasLeftMass && hasRightMass) {
      return k*((rightMass.currentPosition - rightMass.massLength/2) - (leftMass.currentPosition + leftMass.massLength/2) - restLength);
    } else{
      return 0; 
    }
  }
  ArrayList<Node> springNodes() {
    float leftNodeX = leftMass.currentPosition + leftMass.massLength/2;
    float rightNodeX = rightMass.currentPosition - rightMass.massLength/2;
    float theta = asin((abs(rightNodeX - leftNodeX) - 2*straightLength)/((springFolds + 1)*foldLength));
    ArrayList<Node> n = new ArrayList<Node>();
    n.add(new Node(leftNodeX, 0));
    n.add(new Node(leftNodeX + straightLength,0));
    n.add(new Node(leftNodeX + straightLength + foldLength*sin(theta)/2, foldLength*cos(theta)/2));
    
    
    for (int i = 0; i < springFolds; i++) {
      float nx = n.get(i+2).x + foldLength*sin(theta);
      float ny = n.get(i+2).y + pow(-1, i+1)*cos(theta)*foldLength;
      n.add(new Node(nx, ny));
      
    }
      float nx = n.get(springFolds+2).x + foldLength*sin(theta)/2;
      float ny = n.get(springFolds+2).y + pow(-1, springFolds+1)*cos(theta)*foldLength/2;
      n.add(new Node(nx, ny));
      n.add(new Node(nx + straightLength, 0));
      return n;
  }
  
}

class Node {
   float x;
   float y;
   
   Node(float xpos, float ypos) {
      x = xpos;
      y = ypos;
   }
}

void attachSpringToLeftOfMass(Spring s, Mass m) {
   s.rightMass = m;
   s.hasRightMass = true;
   m.leftSpring = s;
   m.hasLeftSpring = true;
}

void attachSpringToRightOfMass(Spring s, Mass m) {
   s.leftMass = m;
   s.hasLeftMass = true;
   m.rightSpring = s;
   m.hasRightSpring = true;
}
