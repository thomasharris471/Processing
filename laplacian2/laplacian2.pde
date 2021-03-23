

float[][] zValues;

int cols;
int rows;

float[][] laplacianValues;

float offset = random(-4000,4000);


void setup() {
  size(600,600,P3D);
  frameRate(5);
  cols = ceil(wid/scl)+1;
  rows = ceil(hit/scl)+1;
  
  zValues = new float[cols][rows];
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) { 
       zValues[i][j] = f((float)map(i, 0, cols-1, -wid/2, wid/2),(float)map(j, 0, rows-1, -hit/2, hit/2));
    }
  }

  
  laplacianValues = new float[cols][rows];

}

void draw() {
  background(0);
  lights();

  
  
  translate(width/2,height/2);
  rotateX(PI/3);
  rotateZ(rotationAmount);
  scale(.7*width/wid);
  translate(0,0,-10);

  displayGraph();
  computeLaplaceValues();
  updatezvalues();
  
  
  if(mousePressed) {
   // perturbBoundary();
 //   makeperturb();
//  runbackwards();
  } else {
    computeLaplaceValues();
    updatezvalues();
  }
  
}

void displayGraphInd() {  
  strokeWeight(.5*wid/width);
  stroke(0);
  noStroke();
  for (int i = 0; i < cols-1; i++) {

    for (int j = 0; j < rows-1; j++) { 
       colorMode(HSB);
       
       beginShape(TRIANGLE);
       fill(abs(map(zValues[i][j], exp(1), exp(3), 0, 255)), 255, 255);
       vertex(map(i, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i][j]);
       vertex(map(i+1, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i+1][j]);
       vertex(map(i, 0, cols-1, -wid/2, wid/2), map(j+1, 0, rows-1, -hit/2, hit/2), zValues[i][j+1]);
       endShape();
       beginShape(TRIANGLE);
       fill(abs(map(zValues[i][j], exp(1), exp(3), 0, 255)), 255, 255);
       vertex(map(i+1, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i+1][j]);
       vertex(map(i+1, 0, cols-1, -wid/2, wid/2), map(j+1, 0, rows-1, -hit/2, hit/2), zValues[i+1][j+1]);
       vertex(map(i, 0, cols-1, -wid/2, wid/2), map(j+1, 0, rows-1, -hit/2, hit/2), zValues[i][j+1]);
       endShape();
       

     }

   }
}

void displayGraph() {
  fill(255);
  strokeWeight(wid/width);
  stroke(0);
//noStroke();
  for (int i = 0; i < cols-1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < rows; j++) { 
       vertex(map(i, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i][j]);
      vertex(map(i+1, 0, cols-1, -wid/2, wid/2), map(j, 0, rows-1, -hit/2, hit/2), zValues[i+1][j]);


     }
     endShape();
   }
}

void updatezvalues() {
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
       zValues[i][j] = zValues[i][j] + deltaT*(laplacianValues[i][j] );
    }
  }
}

void computeLaplaceValues() {
  
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
       laplacianValues[i][j] =  discreteLaplacian(i,j);
    }
  }
}

void runbackwards() {
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
       laplacianValues[i][j] =  discreteLaplacian(i,j);
    }
  }
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
       zValues[i][j] = zValues[i][j] - deltaT*laplacianValues[i][j];
    }
  }
}

void perturbBoundary() {
  for (int i = 0; i < cols; i++) {
      zValues[i][0] = zValues[i][0] + (noise(i+offset,0+offset)-.5);
  }
  for (int i = 0; i < cols; i++) {
      zValues[i][rows-1] = zValues[i][rows-1] + (noise(i+offset,rows-1+offset)-.5);
  }
  for (int j = 0; j < rows; j++) {
      zValues[0][j] = zValues[0][j] + (noise(0+offset,j+offset)-.5);
  }
  for (int j = 0; j < rows; j++) {
      zValues[cols-1][j] = zValues[cols-1][j] + (noise(cols-1+offset,j+offset)-.5);
  }
  
}


void makeperturb() {

  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
       zValues[i][j] = zValues[i][j] + ((noise((float)i/50+offset,(float)j/50+offset)-.5));
    }
  }
  
}
/*
void mouseReleased() {
   offset = random(-4000,4000);
}
*/
