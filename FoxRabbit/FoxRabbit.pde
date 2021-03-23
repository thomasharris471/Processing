import java.util.HashMap;

Controller c;

PGraphics plots;
PGraphics world;

CsvWriter writer;

double time;

void setup() {
  size(2400, 300); 
  c = new Controller(worldWidth, worldHeight);
 // c.addAnimalsRandomLocation(Rabbit.class, intitialRabbits);
 // c.addAnimalsRandomLocation(Fox.class, intitialFoxes);
  
  c.addAnimalsNonRandomRandomLocation(Rabbit.class, intitialRabbits);
  c.addAnimalsNonRandomRandomLocation(Fox.class, intitialFoxes);
  plots = createGraphics(width, height/6);
  world = createGraphics(width, 6*height/6);

  
  writer = new CsvWriter(f);
  
  time = 0;
}


void draw() {
 displayWorld();
 translate(0, 5*height/6);
  for (int  i = 0; i < stepsPerFrame; i++ ) {
    c.update(dt,1);
    displayCount();
    time = time + dt;
  }
}

void displayWorld() {
  world.beginDraw();
  world.background(0); 
  displayAnimals();
//  displayLinks();
  world.endDraw();
  image(world,0,0);
}




void displayCount() {
   HashMap<Class<? extends Animal>, Float> hmap = c.getCount();
   float rabbit;
    float fox;
   if (!hmap.containsKey(Fox.class)) {
     fox = 0;
   } else {
    fox = hmap.get(Fox.class);
   }
   if (!hmap.containsKey(Rabbit.class)) {
     rabbit = 0;
   } else {
     rabbit = hmap.get(Rabbit.class);
   }
     
   writer.write(time, fox, rabbit);
 
}





void displayGrid() {
  stroke(255,0,0);
  PVector p = pixelScale(c.getDX(), c.getDY());
  float dx = p.x;
  float dy = p.y;
  for (int i = 0; i*dx < width; i++) {
    for (int j = 0; j*dy < height; j++) {
      line(i*dx, j*dy, (i+1)*dx, j*dy);
      line(i*dx, j*dy, (i)*dx, (j+1)*dy);
    }
  }
}


void displayLinks() {
  world.stroke(0,255,0);
  ArrayList<VisibleAnimals> v = c.getVisibleAnimals();
  for (int i = 0; i < v.size(); i++) {
    Animal head = v.get(i).getHead();
    ArrayList<Animal> o = v.get(i).getVisible();
    for (int j = 0; j < o.size(); j++) {
      Animal oA = o.get(j);
      float x0 = head.getXPos();
      float y0 = head.getYPos();
      float x1 = oA.getXPos();
      float y1 = oA.getYPos();
      
      //update for torus
      
      float dx = x1 - x0;
      float dy = y1 - y0;
      if (dx > worldWidth/2) {
        dx = dx - worldWidth;
      } 
      if (dx < -worldWidth/2) {
        dx = dx + worldWidth;
      }
      if (dy > worldHeight/2) {
        dy = dy - worldHeight; 
      }
      if (dy < -worldHeight/2) {
        dy = dy + worldHeight;
      }    
      displayLine(x0, y0, x0 + dx, y0 + dy, world);
    }
  }
}




void displayAnimals() {
   world.noStroke();
     ArrayList<Animal> animals = c.getAnimals();
     for (int i = 0; i < animals.size(); i++) {
        Animal a = animals.get(i);
        world.fill(a.getRed(), a.getGreen(), a.getBlue());
        displayEllipse(a.getXPos(), a.getYPos(), a.getSize(), a.getSize(), world);
     }
}


void displayLine(float x0, float y0, float x1, float y1, PGraphics im) {
  PVector p0 = pixelScale(x0, y0, im);
  PVector p1 = pixelScale(x1, y1, im);
  im.line(p0.x, p0.y, p1.x, p1.y);
}

void displayLine(float x0, float y0, float x1, float y1) {
  PVector p0 = pixelScale(x0, y0);
  PVector p1 = pixelScale(x1, y1);
  line(p0.x, p0.y, p1.x, p1.y);
}


void displayEllipse(float x, float y, float dx, float dy) {
  PVector pPos = pixelScale(x,y);
  PVector pD = pixelScale(dx, dy);
  ellipse(pPos.x, pPos.y, pD.x, pD.y);
}

void displayEllipse(float x, float y, float dx, float dy, PGraphics im) {
  PVector pPos = pixelScale(x,y, im);
  PVector pD = pixelScale(dx, dy, im);
  im.ellipse(pPos.x, pPos.y, pD.x, pD.y);
}



void displayPoint(float x, float y, PGraphics im) {
   PVector pPos = pixelScale(x,y, im);
   im.point(pPos.x, pPos.y);
}
PVector pixelScale(float x, float y, PGraphics im) {
   return pixelScale(x, y, im.width, im.height);
}

PVector pixelScale(float x, float y) {
   return pixelScale(x,y, width, height);
}

PVector pixelScale(float x, float y, float w, float h) {
   float xPix = x*(w)/(worldWidth);
   float yPix = y*(h)/(worldHeight);
   return new PVector(xPix, yPix);
}
