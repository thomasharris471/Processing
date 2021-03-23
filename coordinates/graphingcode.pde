color white = color(255,255,255);
color green = color(45,245,0);
color purple = color(162,24,170);
color backgroundColor = color(10,10,10);

PVector pixelScale(float x, float y) {
   float xPix = x*width/(xRange[1] - xRange[0]);
   float yPix = y*width/(yRange[1] - yRange[0]);
   return new PVector(xPix, yPix);
}

void displayXYGraph(String xText, String yText, float xSize, float ySize) {
  line(-xSize, 0, xSize, 0);
  line(0, -ySize, 0, ySize);
  textSize(40);
  text(xText, width/3, 0);
  text(yText, 0, -height/3);
}
