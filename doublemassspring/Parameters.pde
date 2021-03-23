// M X'' + K X = F(t)
ArrayList<Mass> masses;
ArrayList<Spring> springs;

//time step
final static float dt = 0.01;
final static int stepsPerFrame = 5;

void initializeMassesAndSprings() {
   masses = new ArrayList<Mass>();
   
   //wall
   masses.add(new Mass(0));
   
   //masses
   masses.add(new Mass(2, 10, 0));
   masses.add(new Mass(1, 30, 20));
//   masses.add(new Mass(30, 180, 0));
   
   //wall
 //  masses.add(new Mass(400));
   

   springs = new ArrayList<Spring>();
   springs.add(new Spring(4));
   springs.add(new Spring(2));
  // springs.add(new Spring(10));
  // springs.add(new Spring(10));
   

   
   
}



//region you see in the plot
final static float[] xLength = {-10, 400};
final static float[] yLength = {-20, 70};




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
