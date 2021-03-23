float f(float x, float y) {
 // return 5*sin(x*y*2*PI*10/(hit*wid));
  //return (y+wid/2)/wid*(x + wid/2)*(x+wid/2)/wid;
  //return (y - wid/2)*x*x/(wid*wid);
  return exp(4*noise(x/10+offset,y/10+offset));

}



float wid = 20;
float hit = 20;

float scl = .3;

float deltaT = .01;

float colorScale = 10;
