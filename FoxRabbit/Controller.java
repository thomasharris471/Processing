import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.HashMap;

public class Controller {
  
  private ArrayList<Animal> animals;
  private float worldWidth;
  private float worldHeight;
  
  private Data data;

  
  
  public Controller() {
    this(1000,1000);
  }
  
  
   public Controller(float wid, float hit) {
    worldWidth = wid;
    worldHeight = hit;
    animals = new ArrayList<Animal>();
    data = new Data();
  }
  
    public void update(double dt, int steps) {
    for (int i = 0; i < steps; i++) {
      this.behaveAnimals(dt);
      this.addChildren();
    //  this.updateCount();
      this.cleanup();
    }
  }
  
  public Data getData() {
    return data; 
  }
  
  public void updateCount() {
     data.updateCount(this.getCount());
  }
  
  public HashMap<Class<? extends Animal>, Float> getCount() {
    HashMap<Class<? extends Animal>, Float> hmap = new HashMap<Class<? extends Animal>, Float>();
    for (int i = 0; i < animals.size(); i++) {
      Animal a = animals.get(i);
      Class<? extends Animal> c = a.getClass();
      float curVal = 0;
      if (hmap.containsKey(c)) {
        curVal = hmap.get(c);
      }
      hmap.put(c, curVal + 1);
    }
    return hmap;
  }
  
  
  public void addChildren() {
    for (int i = 0; i < animals.size(); i++) {
      Animal a= animals.get(i);
      animals.addAll(a.getChildren());
      a.clearChildren();
    }
  }
  
  public void cleanup() {
     torusPositionCorrection();
     Iterator<Animal> iter = animals.iterator();
     while(iter.hasNext()) {
        Animal a= iter.next();
        if (!a.getAlive()) {
          iter.remove(); 
        }
     }
  }
  
  
  public void behaveAnimals(double dt) {
    ArrayList<VisibleAnimals> v = this.getVisibleAnimals();
    Collections.sort(v);
    for (int i = 0; i < v.size(); i++) {
       Animal head = v.get(i).getHead();
       ArrayList<Animal> visible = v.get(i).getVisible();
       head.behave(visible, dt);
     }
  }
  
  
  public ArrayList<VisibleAnimals> getVisibleAnimals() {
    return new Grid().visibles();
  }
  
  public void addAnimalsNonRandomRandomLocation(Class<? extends Animal> c, int number) {
    for (int i = 0; i < number; i++) {
      try {
       animals.add(c.newInstance());
      } catch (Exception e) {
        System.out.println("caught");
        e.printStackTrace();
      } 
    }
     for (int i = 0; i < animals.size(); i++) {
      float x = (float)Math.random()*worldWidth;
      float y = (float)Math.random()*worldHeight;
      if (animals.get(i).getClass() == Rabbit.class) {
        x = 50 + (float)Math.random()*300;
      }
      if (animals.get(i).getClass() == Fox.class) {
        x = (float)Math.random()*50;
      }    
      animals.get(i).move(x,y);
    }
  } 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  public void addAnimalsRandomLocation(Class<? extends Animal> c, int number) {
    for (int i = 0; i < number; i++) {
      try {
       animals.add(c.newInstance());
      } catch (Exception e) {
        System.out.println("caught");
        e.printStackTrace();
      } 
    }
    randomizeLocations();
  } 

  public ArrayList<Animal> getAnimals() {
    return animals; 
  }
  

  public float getMaxInteractionRange() {
    float m = 0;
    for (int i = 0; i < animals.size(); i++) {
      Animal a = animals.get(i);
      if (a.getInteractionRange() > m) {
        m =  a.getInteractionRange();
      }
    }
    return m;
  }
  
  
  private void randomizeLocations() {
    for (int i = 0; i < animals.size(); i++) {
      float x = (float)Math.random()*worldWidth;
      float y = (float)Math.random()*worldHeight;
      animals.get(i).move(x,y);
    }
  }
  
  
  private void torusPositionCorrection() {
    for (int i = 0; i < animals.size(); i++) {
      Animal a = animals.get(i);
      float x = a.getXPos();
      float y= a.getYPos();
      if (x < 0) {
        x = x + worldWidth; 
      }
      if (x >= worldWidth) {
        x = x - worldWidth; 
      }
      if (y < 0) {
        y = y + worldHeight; 
      }
      if (y >= worldHeight) {
        y = y - worldHeight; 
      }
      a.move(x,y);
    }
  }
  
  public float getDX() {
    return new Grid().dx;
  }
  public float getDY() {
    return new Grid().dy;
  }
  

  
  public class Grid {
    
     private float maxRange;
     private ArrayList<ArrayList<Square>> squares;
     
     private int xGrids;
     private int yGrids;
     
     public float dx;
     public float dy;
    
     public Grid() {
       maxRange = getMaxInteractionRange();
       squares = new ArrayList<ArrayList<Square>>();
       xGrids = (int) Math.floor(worldWidth/maxRange);
       yGrids = (int) Math.floor(worldHeight/maxRange);
       dx = (float) worldWidth/xGrids;
       dy = (float) worldHeight/yGrids;
       populateSquares();
      // checkThatPopulateWorks();
     }
     
     
     public ArrayList<VisibleAnimals> visibles() {
       ArrayList<VisibleAnimals> v = new ArrayList<VisibleAnimals>();
       for (int i = 0; i < animals.size(); i++) {
         Animal a = animals.get(i);
         ArrayList nearby = nearBy(a);
         v.add(new VisibleAnimals(a, nearby));
       }
       return v;
     }
     
     
     public ArrayList<Animal> nearBy(Animal a) {
       float xPos = a.getXPos();
         float yPos = a.getYPos();
         int xGL= (int) Math.floor(xPos/dx);
         int yGL = (int) Math.floor(yPos/dy);
       ArrayList<Animal> near = new ArrayList<Animal>();
       ArrayList<Integer> horizontalLocations = new ArrayList<Integer>();      
        ArrayList<Integer> verticalLocations = new ArrayList<Integer>(); 
       int left = xGL - 1;
       int right = xGL + 1;
       int up = yGL + 1;
       int down = yGL - 1;
       if (xGL <= 0) {
         left = xGrids - 1; 
       }
       if (xGL >= xGrids - 1) {
         right = 0; 
       }
       if (yGL <= 0) {
         down = yGrids - 1; 
       }
       if (yGL >= yGrids - 1) {
         up = 0; 
       }
      horizontalLocations.add(left);
      horizontalLocations.add(xGL);
      horizontalLocations.add(right);
      verticalLocations.add(up);
      verticalLocations.add(yGL);
      verticalLocations.add(down);
      ArrayList<Square> s = new ArrayList<Square>();
      for (int i = 0; i < horizontalLocations.size(); i++) {
        for (int j = 0; j < verticalLocations.size(); j++) {
          int x = horizontalLocations.get(i);
          int y = verticalLocations.get(j);
          near.addAll(nearByInGrid(a, squares.get(x).get(y)));
        }
      }
     return near;
     }
     
     public ArrayList<Animal> nearByInGrid(Animal a, Square s) {
       ArrayList<Animal> near = new ArrayList<Animal>();
       ArrayList<Animal> square = s.getAnimals();
       float interactionRange = a.getInteractionRange();
       for (int i = 0; i < square.size(); i++) {
         if (interactionRange > getDistance(a, square.get(i))) {
           near.add(square.get(i)); 
         }
       }
       return near;
     }
         
     
     private float getDistance(Animal a, Animal b) {
      float x1 = a.getXPos();
      float x2 = b.getXPos();
      float y1 = a.getYPos();
      float y2 = b.getYPos();
      float dx = (float)Math.abs(x2 - x1);
      float dy = (float)Math.abs(y2 - y1);
      if (dx > worldWidth/2) {
        dx = worldWidth - dx; 
      }
      if (dy > worldHeight/2) {
        dy = worldHeight - dy; 
      }
    return (float) Math.sqrt(dx*dx + dy*dy);
   }
     
            
     private void populateSquares() {
       for (int a = 0; a < xGrids; a++) {
         squares.add(a, new ArrayList<Square>());
         for (int b = 0; b < yGrids; b++) {
            squares.get(a).add(b, new Square());
         }
       }
       
       for (int i = 0; i < animals.size(); i++) {
         Animal a = animals.get(i);
         float xPos = a.getXPos();
         float yPos = a.getYPos();
         int gridLocX = (int) Math.floor(xPos/dx);
         int gridLocY = (int) Math.floor(yPos/dy);
         if (gridLocX < 0 || gridLocX > squares.size()-1) {
           System.out.println(xPos);
            System.out.println(gridLocX); 
         }
         if (gridLocY < 0 || gridLocY > squares.get(gridLocX).size()-1) {
             System.out.println(yPos);
            System.out.println(gridLocY); 
         }
         squares.get(gridLocX).get(gridLocY).add(a);
       }        
     }
     
     private void checkThatPopulateWorks() {
       for (int i = 0; i < xGrids; i++) {
         for (int j = 0; j < yGrids; j++) {
            ArrayList<Animal> b = squares.get(i).get(j).getAnimals();
            for (int k = 0; k < b.size(); k++) {
              Animal c = b.get(k);
              c.setColor(5*i, 5*j, 5*(i - j));
            }
         }
       }
     }
       
     
     public class Square {
        private ArrayList<Animal> animalsInGrid;
        public Square() {
          animalsInGrid = new ArrayList<Animal>();
        }
        
        public void add(Animal a) {
          animalsInGrid.add(a); 
        }
        
        public ArrayList<Animal> getAnimals() {
          return animalsInGrid;
        }
     }
     
    
  }
  
 
  
  
}
