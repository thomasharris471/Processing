int totalNumbers = 210;
int totalNumbers2 = 211;
int totalNumbers3 = 212;
int totalNumbers4 = 213;

int strokeOpacity = 50;
int strokeOpacity2 = 50;
int strokeOpacity3 = 50;
int strokeOpacity4 = 50;



float radius = 150;
int numberOfFramestoAdvance = 30;
int numberofFramesToPause = 60;



float numberofJumps = 0;

float practicalJumps;
boolean shouldPause;
int currentFramesCounted;
int TOMframeCount;
float deltaStep;

PGraphics pg;

int totalFrameCount;





void setup() {
  pg = createGraphics(1280, 720);
  //frameRate(30);
  
  practicalJumps = numberofJumps;
  
  shouldPause = false;
  currentFramesCounted = 0;
  TOMframeCount = 1;
  totalFrameCount = 1;
  
  while(numberofJumps <= max(totalNumbers, totalNumbers2, totalNumbers3) || numberofJumps <= totalNumbers4) {
    pg.beginDraw();
    if(!shouldPause) {
    pg.background(0);
    if(numberofJumps <= max(totalNumbers, totalNumbers2, totalNumbers3) || numberofJumps <= totalNumbers4) {
    
      if(TOMframeCount % numberOfFramestoAdvance == 1) {
        numberofJumps++;
      }
      deltaStep = (float)((TOMframeCount-1) % numberOfFramestoAdvance)/(numberOfFramestoAdvance);
      practicalJumps = numberofJumps + (float)(sin(PI*deltaStep - PI/2)+1)/2;
      
      pg.translate(pg.width/2, pg.height/2);
      pg.textSize(32);
      pg.text(practicalJumps, -70, 300);
     
      pg.translate(-pg.width/4,-pg.height/4);
      
      pg.textSize(32);
      pg.text(totalNumbers, -250, 0);


      pg.stroke(255,255,255,strokeOpacity); 
      if(numberofJumps <= totalNumbers) {
        for (int j = 0; j < totalNumbers; j++) {
          
  
          pg.line(radius*cos(PI + 2*PI*j/totalNumbers), radius*sin(PI + 2*PI*j/totalNumbers), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers));
        }
      }
      pg.translate(pg.width/2,0);
      
      pg.textSize(32);
      pg.text(totalNumbers2, 200, 0);
     if(numberofJumps <= totalNumbers2) {
     for (int j = 0; j < totalNumbers2; j++) {
        pg.stroke(255,255,255,strokeOpacity2);
        pg.line(radius*cos(PI + 2*PI*j/totalNumbers2), radius*sin(PI + 2*PI*j/totalNumbers2), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers2), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers2));
      }
     }
      
      pg.translate(0,pg.height/2);
      
      pg.textSize(32);
      pg.text(totalNumbers4, 200, 0);
     if(numberofJumps <= totalNumbers4) {
     for (int j = 0; j < totalNumbers4; j++) {
        pg.stroke(255,255,255,strokeOpacity4);
        pg.line(radius*cos(PI + 2*PI*j/totalNumbers4), radius*sin(PI + 2*PI*j/totalNumbers4), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers4), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers4));
      }
     }
      
      pg.translate(-pg.width/2,0);
      
      pg.textSize(32);
      pg.text(totalNumbers3, -250, 0);
     if(numberofJumps <= totalNumbers3) {
     for (int j = 0; j < totalNumbers3; j++) {
        pg.stroke(255,255,255,strokeOpacity3);
        pg.line(radius*cos(PI + 2*PI*j/totalNumbers3), radius*sin(PI + 2*PI*j/totalNumbers3), radius*cos(PI + 2*PI*practicalJumps*j/totalNumbers3), radius*sin(PI + 2*PI*practicalJumps*j/totalNumbers3));
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
  pg.endDraw();
  //pg.save(String.format("%07d", totalFrameCount) + ".tif");
  totalFrameCount++;
  }
  
  println("ALL DONE");
  
}
