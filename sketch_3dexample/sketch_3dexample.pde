float cols,rows;
float scl = 0.1;
float w = 10;
float h = 10;
 float mod;

void setup() {
  size(600,600,P3D);
  cols = w/scl;
  rows = h/scl;

}

void draw() {
  background(0);
    //directionalLight(180, 102, 126, 0, 0, -50);
    lights();
stroke(20, 20,20, 50);
strokeWeight(.1);
  //noFill();
noStroke();

 mod = cos((float)frameCount/100);
 
  translate(width/2,height/2);
       //translate(0,600,0);
    rotateX(PI/3);
          rotateZ((float)frameCount/100);
    translate(-w/2, -h/2);
    //translate(0,0,700);

    
 scale(20);
 translate(0,0,5);
  for (int y = 0; y < rows; y++) {
      beginShape(TRIANGLE_STRIP);
      
      for (int x = 0; x < cols; x++) {
        /*
  beginShape(TRIANGLE);
      vertex(x*scl,y*scl, f(x,y));
     vertex((x+1)*scl,y*scl, f(x+1,y));
      vertex(x*scl, (y+1)*scl, f(x,y+1));
       endShape();
         beginShape(TRIANGLE);
      vertex((x+1)*scl,y*scl, f(x,y));
     vertex((x+1)*scl,(y+1)*scl, f(x+1,y));
      vertex(x*scl, (y+1)*scl, f(x,y+1));
       endShape();
*/
        vertex(x*scl,y*scl, f(x,y));
      vertex(x*scl, (y+1)*scl, f(x,y+1));
    }
    endShape();
         
  }
  

  
  
}

  float f(float x, float y) {
     return sin(x*y/500) ; 
  }
