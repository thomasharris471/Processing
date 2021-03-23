int totalNumbers = 210;
int totalNumbers2 = 211;
int totalNumbers3 = 212;
int totalNumbers4 = 213;

int strokeOpacity = 255;
int strokeOpacity2 = 255;
int strokeOpacity3 = 255;
int strokeOpacity4 = 255;



float radius = 150;
int numberOfFramestoAdvance = 30;
int numberofFramesToPause = 60;



float numberofJumps = 0;

float practicalJumps;
boolean shouldPause;
int currentFramesCounted;
int TOMframeCount;
float deltaStep;


void setup() {
  size(1280,720);
  //frameRate(30);
  strokeWeight(0.1);
  
  practicalJumps = numberofJumps;
  
  shouldPause = false;
  currentFramesCounted = 0;
  TOMframeCount = 1;

  
}

void draw() {
  if(!shouldPause) {
    background(0,0,0);
    if(numberofJumps <= max(totalNumbers, totalNumbers2, totalNumbers3) || numberofJumps <= totalNumbers4) {
    
      if(TOMframeCount % numberOfFramestoAdvance == 1) {
        numberofJumps++;
      }
      deltaStep = (float)((TOMframeCount-1) % numberOfFramestoAdvance)/(numberOfFramestoAdvance);
      practicalJumps = numberofJumps + (float)(sin(PI*deltaStep - PI/2)+1)/2;
      
      translate(width/2, height/2);
      textSize(32);
      text(practicalJumps, -70, 300);
     
      translate(-width/4,-height/4);
      
      textSize(32);
      text(totalNumbers, -250, 0);


      stroke(255,255,255,strokeOpacity); 
      if(numberofJumps <= totalNumbers) {
        for (int j = 0; j < totalNumbers; j++) {
          
  
          line(radius*cos(PI + 2*PI*j/totalNumbers), radius*sin(PI + 2*PI*j/totalNumbers), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers));
        }
      }
      translate(width/2,0);
      
      textSize(32);
      text(totalNumbers2, 200, 0);
     if(numberofJumps <= totalNumbers2) {
     for (int j = 0; j < totalNumbers2; j++) {
        stroke(255,255,255,strokeOpacity2);
        line(radius*cos(PI + 2*PI*j/totalNumbers2), radius*sin(PI + 2*PI*j/totalNumbers2), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers2), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers2));
      }
     }
      
      translate(0,height/2);
      
      textSize(32);
      text(totalNumbers4, 200, 0);
     if(numberofJumps <= totalNumbers4) {
     for (int j = 0; j < totalNumbers4; j++) {
        stroke(255,255,255,strokeOpacity4);
        line(radius*cos(PI + 2*PI*j/totalNumbers4), radius*sin(PI + 2*PI*j/totalNumbers4), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers4), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers4));
      }
     }
      
      translate(-width/2,0);
      
      textSize(32);
      text(totalNumbers3, -250, 0);
     if(numberofJumps <= totalNumbers3) {
     for (int j = 0; j < totalNumbers3; j++) {
        stroke(255,255,255,strokeOpacity3);
        line(radius*cos(PI + 2*PI*j/totalNumbers3), radius*sin(PI + 2*PI*j/totalNumbers3), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers3), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers3));
      }
     }
    
  
  
      if(TOMframeCount % numberOfFramestoAdvance == 1) {
           shouldPause = true;
      }  
      TOMframeCount++;
    }
  }
  else {
    currentFramesCounted++;
    if (currentFramesCounted >= numberofFramesToPause) {
      shouldPause = false;
      currentFramesCounted = 0;
    }
  }
  if(numberofJumps <= max(totalNumbers, totalNumbers2, totalNumbers3) || numberofJumps <= totalNumbers4) {
    //saveFrame("gol_####.tif");
  }
  
}
