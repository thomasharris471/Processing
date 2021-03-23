String s;
    float x = 10;
int stepSize = 10;
//PFont f = createFont("Georgia", 64);
//PFont g = createFont("Lexica", 64);

void setup() {
  
  size(600,400);
  background(0);
  s = "Hello world";
  /*
  float x = 10;
  for(int i = 0; i < s.length(); i++) {
    char c = s.charAt(i);
    textSize(random(12,128));
    fill(random(0,255),random(0,255),random(0,255),random(0,255));
    text(c, x, 300);
    x = x + textWidth(c);
  }
  */
  
  println(PFont.list());
}

void draw() {
    if ((frameCount-1) < stepSize*s.length() && (frameCount-1) % stepSize == 0) {

    char c = s.charAt((frameCount-1)/stepSize % s.length());
    textSize(64);
    //fill(random(0,255),random(0,255),random(0,255),random(0,255));
    fill(255,255,255);
    textAlign(CENTER);
    text(c, width/2, height/2);
    x = x + textWidth(c);
    }
}
