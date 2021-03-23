class Star {
  
  PShape s;
  float x,y;
  
  Star() {
    s = createShape();
    s.beginShape();
    s.fill(102);
    s.stroke(255);
    s.strokeWeight(2);
    
    s.vertex(0,-50);
    s.vertex(14,-20);
    s.vertex(47,-15);
    s.vertex(23,7);
    s.vertex(29,40);
    s.vertex(0,25);
    s.vertex(-29,40);
    s.vertex(-23,7);
    s.vertex(-47,-15);
    s.vertex(-14,-20);
    s.endShape(CLOSE); 
    x = 0;
    y = 0;
    
  }
 
  
}
