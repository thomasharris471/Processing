import java.util.ArrayList;

public class Rabbit extends Animal {
  
  private int red = 255;
  private int green = 255;
  private int blue = 255;
  private float speed = 70;
  private float size = 3;  
  private float interactionRange = 10;
  private float interactionSpeed = 10;
  
  
  private double reproductionRate = 3;
  private int numberOfChildren = 1;
  
  public Rabbit() {
    this(0,0);
  }
  
  public Rabbit(float xPos, float yPos) {
    super(xPos, yPos); 
    this.setColor(red, green, blue);
    this.setSize(size);
    this.setSpeed(speed);
    this.setInteractionRange(interactionRange);
    this.setInteractionSpeed(interactionSpeed);
    this.setReproductionRate(reproductionRate);
    this.setNumberOfChildren(numberOfChildren);
  }
  
  @Override
  public void behave(ArrayList<Animal> nearbyAnimals, double dt) {
    if (this.isAlive()) {
      this.updateAge(dt);
      this.reproduceAttempt(this.getClass(), dt);
      this.travel(dt);
    }
  }

  

}
