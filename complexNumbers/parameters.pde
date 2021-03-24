//starting number x0 + i y0
double x0 = 2;
double y0 = 0;

//number you multiply by (re^{i \theta})*(x0 + i y0)
double r = 3;
double theta = Math.PI/4;































boolean displayY = false;
boolean displayNumbers = false;
boolean displayTriangle = false;
boolean displaytriangletext = false;
boolean displaytheta = false;
boolean velocityvector = false;
boolean translatedvelocityvector = false;


double[] xAxis = {-7, 7};
double[] yAxis = {-7, 7};


void commands() {
  displayGrid();
  displayVector();
  displayAngleArc();
  if (displaytheta) {
    displayLetterTheta();
  }
 if (displayTriangle) {
   displayTriangle();
 }
 if(displaytriangletext) {
    displayTriangleText();
 }
 if(velocityvector) {
   displayVelocityVector(); 
 }
 if (translatedvelocityvector) {
    displayTranslated(); 
 }
  transformVector();

}





















double dt = 0.002;


double tickDistance = 1;
double tickSize = .1;


double rotateTimeInterval = 1;
double scaleTimeInterval = 1;


color white = color(255,255,255);
color green = color(45,245,0);
color purple = color(162,24,170);
color backgroundColor = color(10,10,10);

color vectorColor =  white;
color actionColor = green;
color gridColor =  purple;
