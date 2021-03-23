import java.util.ArrayList;

public class Animal extends Particle {
  
  protected float xPos;
  protected float yPos;
  protected float interactionRange;
  protected float interactionSpeed;  
  
  protected int health;
  
  
  protected float speed; 
  
  protected double xSeed;
  protected double ySeed;
  
  protected  int red;
  protected  int green;
  protected  int blue;
  
  protected float size;
  
  protected double reproductionRate;
  protected int numberOfChildren;
  

  protected static double dseed = .01;
  
  protected ArrayList<Animal> children;
  
  protected boolean isAlive; 
  
  protected boolean isYoung;
  
  protected double age;
  
  private static float adultAge = 5;
  
  
  
  public Animal() {
    this(0,0);
  }
  
  public Animal(float x, float y) {
    xPos = x;
    yPos = y;
    setSeed();
    children = new ArrayList<Animal>();
    isAlive = true;
    isYoung = false;
    age = 0;
  }
  
  
  public void behave(ArrayList<Animal> nearbyAnimals, double dt) { 
    this.travel(dt);
    this.updateAge(dt);
  }
  
  public void updateAge(double dt) {
    age = age + dt;
    if (age > adultAge) {
      isYoung = false; 
    }
  }
  
  public void setYoung(boolean b) {
     isYoung = b;
  }
  
  public double roleDice() {
    return Math.random()*100;
  }
  
  public void reproduceAttempt(Class<? extends Animal> c, double dt) {
     double rand = Math.random()*100;

     double repNumber = reproductionRate*dt;
     if (rand < repNumber) {
       for (int i = 0; i < numberOfChildren; i++) {
         addChild(c, xPos, yPos); 
       }
     }
  }
  
   public void setNumberOfChildren(int c) {
    numberOfChildren = c;
  }
  
  public void setReproductionRate(double r) {
    reproductionRate = r;
  }
  
  
  public void kill() {
    isAlive = false; 
  }
  
  public boolean isAlive() {
    return isAlive; 
  }
  
  public boolean getAlive() {
    return isAlive; 
  }
  
  public void setAlive(boolean b) {
    isAlive = b; 
  }
  
  
  public ArrayList<Animal> getChildren() {
    return children; 
  }
  
  
  public void clearChildren() {
    children.clear();
  }
  
  public void addChild(Class<? extends Animal> c, float xPos, float yPos) {
     try {
       Animal q = (c.newInstance());
       q.move(xPos, yPos);
       q.setYoung(true);
       children.add(q);
     } catch (Exception e) {
        System.out.println("caught");
        e.printStackTrace();
      } 
  }
  
  
  public void travel(double dt) {
    float dx = (float)((Noise.noise(xSeed))*speed*dt);
    float dy = (float)((Noise.noise(ySeed))*speed*dt);
    xPos = xPos + dx;
    yPos = yPos + dy;
    xSeed = xSeed + dseed;
    ySeed = ySeed + dseed;
  }
  
  
  public void move(float x, float y) {
    xPos = x;
    yPos = y;
  }
  
  public float getXPos() {
    return xPos; 
  }
  
  public float getYPos() {
    return yPos; 
  }

  public int getRed() {
    return red; 
  }
  
  public int getGreen() {
    return green;
  }
  
  public int getBlue() {
    return blue;
  }
  
  public void setColor(int r, int g, int b) {
    red = r;
    green = g;
    blue = b;
  }
  
  public float getSize() {
    if (isYoung) {
      return (float)size/2; 
    } else {
      return size; 
    }
  }
  
  public void setSize(float s) {
    size = s; 
  }

  public float getInteractionSpeed() {
    return interactionSpeed; 
  }

  public void setInteractionSpeed(float s) {
    interactionSpeed = s; 
  }
  
  
  public int getHealth() {
    return health; 
  }
  
  public void setHealth(int h) {
    health = h; 
  }
  
  public void setSpeed(float s) {
    speed = s;  
  }
  
 

  public float getInteractionRange() {
    return interactionRange; 
  }
  
  public void setInteractionRange(float r) {
    interactionRange = r; 
  }
  

  
  private void setSeed() {
    xSeed =  Math.random()*10000000;
    ySeed =  Math.random()*10000000;
  }
  
}
