void setup() {
  background(0);
  size(300,300);
  PFont myFont = createFont("LatinModernMath-Regular", 128, true);
  PFont oFont = createFont("TeXGyreTermesMath-Regular", 200, true);
  PFont uFont = createFont("UnifrakturMaguntia", 200, true);
  textFont(myFont);
  String y = new StringBuilder().appendCodePoint(0x1D58C).toString();
  text(y, width/4, height/2);
  
  //is this stuff not saving
}
