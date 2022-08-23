//notes for next time, it seems my RREF algorithm  works
import java.util.ArrayList;

import peasy.*;

PeasyCam cam;

boolean twoDplotmode = false;

Matrix matrix;
ArrayList<Matrix> steps;
int current = 0;

float scale = 50;




void setup() {
  size(1000,1000,P3D);
  cam = new PeasyCam(this, 0,0,0,600);
  cam.setMinimumDistance(1);
  cam.setMaximumDistance(5000);
  
  if(mat[0].length == 3) {
    twoDplotmode = true; 
  }
   if(twoDplotmode) {
     mat = convert2dto3d(mat); 
   }
  
  matrix = new Matrix(mat);
  /*
  println(matrix.toString());
  Matrix ref = Matrix.ref(matrix);
  println(ref.toString());
  println((Matrix.swapRows(matrix, 0, 1)).toString());
 // println((Matrix.scaleRow(matrix, 2, 7)).toString());
  // println((Matrix.replaceRow(matrix, 2, 0, -1)).toString());
   println(ref.toString());
   */
   
   steps = Matrix.interoplatedMatrices(matrix, numberOfStepsBetween);
   for (int i = 0; i < steps.size(); i++) {
     println(steps.get(i).prettytoString()); 
   }
   
 //  Matrix holder = Matrix.matCopy(matrix);
   //println(holder.toString());
//   for (int i =0; i < 10; i++) {
 //    holder = Matrix.steppedREF(holder);
 //    println(holder.prettytoString());
 //  }
   
   //println("done");
   

    generatelargematrix();
}
void draw() {
  background(0);
  fill(255,255,255);
  stroke(255,255,255,255);
  box(20);
   if(twoDplotmode) {
      displaynumbers();

   }
if (showintersection) {
          displayintersection() ; 
}
  drawAxes();

 // drawPlane();
  //drawPlane2();
  //drawPlane3();
  //displayMatrix(matrix);
  if (reduce) {
    displayMatrix(steps.get(current));
  } else {
     displayMatrix(steps.get(0));
  }
  if (current < steps.size() - 1) {
    current++;  
  }
}

void drawAxes() {
  stroke(255);
  line(-1000, 0, 0, 1000, 0, 0); 
  line(0, -1000, 0, 0, 1000, 0); 
  line(0, 0, -1000, 0, 0, 1000); 
}



float[][] convert2dto3d(float[][] old) {
  float[][] numatrix = new float[old.length][4];
  for (int r = 0; r < old.length; r++) {
    numatrix[r][0] = old[r][0];
    numatrix[r][1] = old[r][1];
    numatrix[r][2] = 0;
    numatrix[r][3] = old[r][2];
  }
  return numatrix;
}

void displayMatrix(Matrix matrix) {
  for (int row = 0; row < matrix.rows; row++) {
    float[] rowVector = matrix.entries[row];
    displayRowSet(rowVector, row);
  }
}

void displayintersection() {
  Matrix finalmatrix = steps.get(steps.size() - 1);
  float xlocation = finalmatrix.entries[0][3];
  float ylocation = finalmatrix.entries[1][3];
   float zlocation;
  if (!twoDplotmode) {
    zlocation = finalmatrix.entries[2][3];
  } else {
    zlocation = 0;
  }
  
  
   pushMatrix();
   scale(1,-1,1);
   translate(scale*xlocation, scale*ylocation, scale*zlocation);
   box(5);
   popMatrix();
  
}

void displayRowSet(float[] rowVector, int colorCode) {
  float a = rowVector[0];
  float b = rowVector[1];
  float c = rowVector[2];
  float d = rowVector[3];
  float base = 10;
  float xLeft = -base;
  float xRight = base;
  float yLeft = -base;
  float yRight = base;
      float zLeft = -base;
    float zRight = base;
    if(twoDplotmode) {
      zLeft = 0;
      zRight = 0;
    }
    

    
   if (colorCode == 0) {
     fill(0, 0, 255, 120); 
     stroke(0, 0, 255, 255);
   } else if (colorCode == 1) {
     fill(0, 255, 0, 120); 
     stroke(0, 255, 0, 255);
   } else if (colorCode == 2) {
     fill(255, 0, 0, 120); 
     stroke(255, 0, 0, 255);
   } else {
     fill(255, 255, 255, 120);
     stroke(255,255,255,255);
   }

   pushMatrix();
   scale(1,-1,1);
  if (c != 0) {
      beginShape();
      vertex(scale*xLeft, scale*yLeft, scale*(d - a*xLeft - b*yLeft)/c);
      vertex(scale*xRight, scale*yLeft, scale*(d - a*xRight - b*yLeft)/c);
      vertex(scale*xRight, scale*yRight, scale*(d - a*xRight - b*yRight)/c);
      vertex(scale*xLeft, scale*yRight, scale*(d - a*xLeft - b*yRight)/c);
      endShape();
  } else if (b != 0) {

     beginShape();
      vertex(scale*xLeft, scale*(d-a*xLeft)/b, scale*zLeft);
       vertex(scale*xLeft, scale*(d-a*xLeft)/b, scale*zRight);
        vertex(scale*xRight, scale*(d-a*xRight)/b, scale*zRight);
         vertex(scale*xRight, scale*(d-a*xRight)/b, scale*zLeft);
      endShape();
  } else if (a != 0) {
    beginShape();
      vertex(scale*d/a, scale*yLeft, scale*zLeft);
       vertex(scale*d/a, scale*yLeft, scale*zRight);
        vertex(scale*d/a, scale*yRight, scale*zRight);
         vertex(scale*d/a, scale*yRight, scale*zLeft);
      endShape();
  }
  popMatrix();
}

void displaynumbers() {
  for (int i = -20; i <= 20; i++) {
    textSize(20);
    textAlign(CENTER, CENTER);
    text(i, scale*i, 0);
    text(-i, 0, scale*i);
  }
}

void generatelargematrix() {
   int numberOfRows = 8;
   int numberOfColumns = 9;
   float[][] largemat = new float[numberOfRows][numberOfColumns];
   for (int r = 0; r < numberOfRows; r++ ) {
     for (int c = 0; c < numberOfColumns; c++) {
       largemat[r][c] = (float) Math.floor((float) ((int) 20*Math.random() - 10));
     }
   }
   String systemofequations = "\\begin{align} \\begin{matrix}";
   for (int r = 0; r < numberOfRows; r++) {
     for (int c= 0; c < numberOfColumns; c++) {
       if (c == numberOfColumns - 1) {
         systemofequations = systemofequations + "= &" + (int)largemat[r][c] ;
       } else {
       systemofequations = systemofequations + (int)largemat[r][c] + "x_{" + (c+1) + "}" + "+" + " &";
       }
     }
     systemofequations = systemofequations + "\\\\";
   }
   systemofequations =  systemofequations  + "\\end{matrix} \\end{align}";
   
   Matrix largemaobject = new Matrix(largemat);
   largemaobject = Matrix.ref(largemaobject);
   float[][] largemat2 = largemaobject.entries;
   String systemofequations2 = "";
   
   systemofequations2 = "\\begin{align} \\begin{matrix}";
   for (int r = 0; r < numberOfRows; r++) {
     for (int c= 0; c < numberOfColumns; c++) {
       if (c == numberOfColumns - 1) {
         systemofequations2 = systemofequations2 + "= &" + largemat2[r][c] ;
       } else {
         if (Math.abs(largemat2[r][c]) < 0.5 ) {
           systemofequations2 = systemofequations2 +  " " + " &";
         } else {
           systemofequations2 = systemofequations2 + largemat2[r][c] + "x_{" + (c+1) + "}" + " " + " &";
         }
       }
     }
     systemofequations2 = systemofequations2 + "\\\\";
   }
   systemofequations2 =  systemofequations2  + "\\end{matrix} \\end{align}";
   
   println(systemofequations);
  // println(largemaobject.prettytoString());
   println(systemofequations2);
}
