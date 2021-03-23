boolean eGraph = true;
boolean circle = true;

final static int stepsPerFrame = 5;

final static float dt = 0.005;


// M X'' + K X = F(t)
ArrayList<Mass> masses;
ArrayList<Spring> springs;

void initializeMassesAndSprings() {
   masses = new ArrayList<Mass>();
   
   //wall
   masses.add(new Mass(0));
   
   //masses
   masses.add(new Mass(30, 80, 0));
  // masses.add(new Mass(30, 140, 0));
 //  masses.add(new Mass(30, 180, 0));
   
   //wall
  // masses.add(new Mass(400));
   

   springs = new ArrayList<Spring>();
   springs.add(new Spring(30));
 //  springs.add(new Spring(30));
  // springs.add(new Spring(10));
  // springs.add(new Spring(10));
   

   
   
}

//time step



//region you see in the plot
final static float[] xLength = {-10, 250};
final static float[] yLength = {-30, 90};




//rules for attaching objects


void attachObjectsInOrderFirstMassOnLeft() {
   for (int i = 0; i < masses.size()-1; i++) {
      attachSpringToRightOfMass(springs.get(i), masses.get(i));
      attachSpringToLeftOfMass(springs.get(i), masses.get(i+1));
   }
}

void manuallyAttach() {
  
}

void updatePositions() {
  for (int i = 0; i < masses.size(); i++) {
    masses.get(i).getForces(); 
  }
  for (int i = 0; i < masses.size(); i++) {
    masses.get(i).updatePosition(); 
  }
}



float[] f(float t) {
  return new float[] {0,0}; 
}
