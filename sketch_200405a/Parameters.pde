
boolean linearmode = true;

float[] mat = {(float)5,(float)2,(float)4,(float)-4};

//userchanges

float baseTimeStep = 0.002;

float basespeedIncrease = .0005;

float timeStep = 0.0005;

float speedIncrease;




float userScaleIncrease = .01;

float tailLengthIncrease = .01;


float backgroundOpacity = 20;



float gridDensity = 30;

color strokeColor = color(255,255,255);

float strokeOpacity = 255;

float weightOfStroke = 1;


color backColor = color(10,10,10);
float scale = 1;

float intialTime = 200;


float xPrime(float x, float y, float t) {
  return (float)3*x + (float)9*y;
}

float yPrime(float x, float y, float t) {
  return  (float)-4*x  + (float)-3*y;
}

float xPrimeLinear(float x, float y, float t) {
  return (float)mat[0]*x + (float)mat[1]*y;
}

float yPrimeLinear(float x, float y, float t) {
  return  (float)mat[2]*x  + (float)mat[3]*y;
}

boolean hasEigenvector = false;

Position eigenvector1 = new Position(3, 9);
Position eigenvector2 = new Position(-4, -3);

float[][] eigenvalues;



//static


float time;

float currentX;
float currentY;

Position[][] positionArray;
PGraphics currentPositionLayer;



float userScale = 1;
