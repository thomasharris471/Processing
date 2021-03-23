var topLeft;
var topRight;
var bottomLeft;
var bottomRight;

function mouseClicked() {
  if (entryScreen) {
    var shiftedMouseX = mouseX - width/2;
    var shiftedMouseY = mouseY - height/2;
    prvarln(shiftedMouseX);
    prvarln(shiftedMouseY);
    if (shiftedMouseX <= matBoxSize && 0 <= shiftedMouseX && shiftedMouseY >= -matBoxSize && shiftedMouseY <= 0) {
      //topright
        topRight = true;
        topLeft = false;
        bottomLeft = false;
        bottomRight = false;
        prvarln("top right");
    } else if (shiftedMouseX <= matBoxSize && 0 <= shiftedMouseX && shiftedMouseY <= matBoxSize && shiftedMouseY >= 0) {
        //bottomright
        topRight = false;
        topLeft = false;
        bottomLeft = false;
        bottomRight = true;
      prvarln("bottom right");
    }  else if (shiftedMouseX >= -matBoxSize && 0 >= shiftedMouseX && shiftedMouseY <= matBoxSize && shiftedMouseY >= 0) {
        //bottomleft
        topRight = false;
        topLeft = false;
        bottomLeft = true;
        bottomRight = false;
      prvarln("bottom left");
    } else if (shiftedMouseX >= -matBoxSize && 0 >= shiftedMouseX && shiftedMouseY >= -matBoxSize && shiftedMouseY <= 0) {
      //topleft
        topRight = false;
        topLeft = true;
        bottomLeft = false;
        bottomRight = false;
      prvarln("top left");
    } else {
        topRight = false;
        topLeft = false;
        bottomLeft = false;
        bottomRight = false;
    }
  }
}
