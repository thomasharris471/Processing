float time;
float dt = 0.001;
OrthogonalShearScaleDecomposition qrs;

void setup() {
  size(1080,720);
  time = 0;
  vectorsandmatrix();
  qrs = new OrthogonalShearScaleDecomposition(transform);
}

void draw() {
  background(backgroundColor);
  translate(width/2, height/2);
 
  scale(1,-1);
  transform(time);
  displayAxis();
  time = time + dt;
  if (time > 2) {
   time = 0; 
  }
}

void displayAxis() {
  stroke(purple);
  fill(white);
  displayXYGraph("", "", width, height);
}

void transform(float t) {
  if (t <= 0) {
       return;
     }
     else if (t <= 1.0/3.0) {
       shearX(qrs.shearAngle*interpolationFunction(3*t));
     } else if (t <= 2.0/3.0 ) {
       shearX(qrs.shearAngle);
       float it = interpolationFunction(3*(t - 1.0/3.0));
       scale(it-1 + qrs.scaleX*it,it-1  + qrs.scaleY*it);
     } else if (t <= 1) {
       shearX(qrs.shearAngle);
       scale(qrs.scaleX, qrs.scaleY);
       rotate(qrs.rotationAngle*interpolationFunction(3*(t - 2.0/3.0)));
     } else {
        shearX(qrs.shearAngle);
       scale(qrs.scaleX, qrs.scaleY);
       rotate(qrs.rotationAngle);
     } 
}
