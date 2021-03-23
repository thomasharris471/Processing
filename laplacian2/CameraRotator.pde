float rotationAmount = 0;

float baseX;
boolean wasDragged = false;

void mouseDragged() {
  if(!wasDragged) {
    baseX = mouseX;
    wasDragged = true;
  } else {
    rotationAmount = rotationAmount - (float)(mouseX - baseX)/100;
    baseX = mouseX;
  }
}

void mouseReleased() {
  wasDragged = false; 
}
