void displayXYGraph(String xText, String yText, float xSize, float ySize) {
  line(-xSize, 0, xSize, 0);
  line(0, -ySize, 0, ySize);
  textSize(40);
  text(xText, width/3, 0);
  text(yText, 0, -height/3);
}
