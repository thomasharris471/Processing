//this is your differential equation
float yPrime(float x, float y, float t) {
  return f(x,y);
}

float yPrime2(float x, float y, float t) {
  return ode2(x,y);
}


float xPrime(float x, float y, float t) {
  return 1;
}



//this is how zoomed out you are. Roughly think of it as saying what your x-axis goes up to


//make this number larger for faster simulation, smaller for slower simulation


//this sets the center of the coordinate system
float[] center = {0,0};








//this is the number of particles in one horizontal direciton, so the actual number of particles is like this squared



















//you shouldn't need to edit anything below this line

color backgroundColor = color(0,0,0);
float backgroundOpacity = 5;

color axisColor = color(162,24,170);
float axisOpacity = 60;

color textColor = color(45,245,0);;
float textOpacity = 60;

color strokeColor = color(255,255,255);
float strokeOpacity = 255;
float weightOfStroke = 1;

color oStrokeColor = color(0,255,0);

boolean randomMode = false;

//this is your differential equation
float xPrimeRandom(float x, float y, float t) {
  return random(-5,5) + random(-5,5)*x + random(-5,5)*y + random(-5,5)*x*y + random(-5,5)*pow(x,2) + random(-5,5)*pow(y,2);
}

float yPrimeRandom(float x, float y, float t) {
  return random(-5,5) + random(-5,5)*x + random(-5,5)*y + random(-5,5)*x*y + random(-5,5)*pow(x,2) + random(-5,5)*pow(y,2);
}
