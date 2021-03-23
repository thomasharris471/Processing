boolean topLeft;
boolean topRight;
boolean bottomLeft;
boolean bottomRight;

void mouseClicked() {
  if (entryScreen) {
    float shiftedMouseX = mouseX - width/2;
    float shiftedMouseY = mouseY - height/2;
    println(shiftedMouseX);
    println(shiftedMouseY);
    if (shiftedMouseX <= matBoxSize && 0 <= shiftedMouseX && shiftedMouseY >= -matBoxSize && shiftedMouseY <= 0) {
      //topright
        topRight = true;
        topLeft = false;
        bottomLeft = false;
        bottomRight = false;
        println("top right");
    } else if (shiftedMouseX <= matBoxSize && 0 <= shiftedMouseX && shiftedMouseY <= matBoxSize && shiftedMouseY >= 0) {
        //bottomright
        topRight = false;
        topLeft = false;
        bottomLeft = false;
        bottomRight = true;
      println("bottom right");
    }  else if (shiftedMouseX >= -matBoxSize && 0 >= shiftedMouseX && shiftedMouseY <= matBoxSize && shiftedMouseY >= 0) {
        //bottomleft
        topRight = false;
        topLeft = false;
        bottomLeft = true;
        bottomRight = false;
      println("bottom left");
    } else if (shiftedMouseX >= -matBoxSize && 0 >= shiftedMouseX && shiftedMouseY >= -matBoxSize && shiftedMouseY <= 0) {
      //topleft
        topRight = false;
        topLeft = true;
        bottomLeft = false;
        bottomRight = false;
      println("top left");
    } else {
        topRight = false;
        topLeft = false;
        bottomLeft = false;
        bottomRight = false;
    }
  }
}
