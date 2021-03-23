int totalNumbers = 1056;
float numberOfJumps;
float radius = 300;
float stepSize = 1;



void setup() {
  size(1280,720);
  strokeWeight(0.01);
  numberOfJumps = 900;
  background(0);
  frameRate(120);
}

void draw() {

   //fill(0,0,0,.01);
   if (frameCount % totalNumbers == 1) {
     numberOfJumps = numberOfJumps + stepSize;
     fill(0,0,0,5);
     rect(0,0,width,height);
   }
   float startingAngle = PI + 2*PI*frameCount/totalNumbers;
   float endingAngle = PI + 2*PI*numberOfJumps*frameCount/totalNumbers;
   translate(width/2, height/2);
   stroke(255,255,255,20);
   line(radius*cos(startingAngle), radius*sin(startingAngle), radius*cos(endingAngle), radius*sin(endingAngle));
  
}
