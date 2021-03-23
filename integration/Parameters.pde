function f = new function() {
   @Override
   double apply(double x) {
     return 2*(-1.6+exp(noise((float)x/2+100)));
   }
};


float[] domain = {-10,10};

float[] range = {-2,2};


float rectWidth = 1;

int partitions = 1;


//aesthetic
color plotColor = color(255,255,255,255);
float plotstrokeWeight = 2;


color backgroundColor = color(10,10,10,255);

color axisColor = color(162,24,170,255);
float axisstrokeWeight = 2;


color integralColor = color(45,245,0,160);
color integralBoundaryColor = color(0,0,0,255);
float intstrokeWeight = 0;
