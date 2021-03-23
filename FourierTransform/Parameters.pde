float f(float t) {
  return sin(10*t); 
}

float frequency = -3;

float[] domain = {-50,50};

float[] range = {-2,2};

float dt = .1;

//aesthetic
color plotColor = color(255,255,255,255);
float plotstrokeWeight = 2;


color backgroundColor = color(10,10,10,255);

color axisColor = color(162,24,170,255);
float axisstrokeWeight = 2;
