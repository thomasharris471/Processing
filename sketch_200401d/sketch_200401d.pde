int index;
int numberOfRows;
int numberOfColumns;

void setup() {
  
  size(800,450);
  
  numberOfRows = 800/20;
  numberOfColumns = 450/30;
  index = 0;
  background(0);
}

void draw() {
  if(frameCount % 2 == 0) {
  if (index > numberOfColumns) {
    background(0);
    index = 0;
  }
  for (int j = 0; j < numberOfRows; j++) {
    stroke(255);
    point(index*width/numberOfColumns, j*height/numberOfRows);
    stroke(255,255,255,20);
    line(width/2, height/2, index*width/numberOfColumns, j*height/numberOfRows);
  }
  index = (index + 1);
  }
}
