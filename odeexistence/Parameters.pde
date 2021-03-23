//y' = f(t, y(t))

float f(float t, float y) {
  return -y*sin(t); 
}

//initial condition, y(0)

float t0 = 0;
float y0 = 1;
