float wid = 90;
float hit = 100;

float scl = 2;

float[][] zValues;

int cols;
int rows;

void setup() {
  size(600,600,P3D);

}

void draw() {
  background(0);
  lights();
  scl = cos((float)frameCount/500)+1.3;
//scl = .1;
    cols = ceil(wid/scl);
  rows = ceil(hit/scl);
  zValues = new float[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) { 
    // zValues[i][j] = f((float)i*scl-wid/2,(float)j*scl - hit/2 );
       zValues[i][j] = f((float)map(i, 0, cols-1, -wid/2, wid/2),(float)map(j, 0, rows-1, -hit/2, hit/2));
      // if (abs((float)i*scl-wid/2 - map(i, 0, cols-1, -wid/2, wid/2)) > 2) {
      //   println((float)i*scl-wid/2 + "," + map(i, 0, cols-1, -wid/2, wid/2));
    //   }
     }
   }
  
  
  
  translate(width/2,height/2);
  scale(8);
  strokeWeight(.1);
  stroke(0,0,0,100);
   rotateX(PI/2);
 // noStroke();
  
  for (int i = 0; i < cols-1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < rows; j++) { 
      // vertex((float)i*scl-wid/2, (float)j*scl - hit/2, zValues[i][j]);
       vertex(map(i, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i][j]);
       vertex(map(i+1, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i+1][j]);
     // vertex((float)(i+1)*scl-wid/2, (float)j*scl - hit/2, zValues[i+1][j]);
     }
     endShape();
   }
  
}
