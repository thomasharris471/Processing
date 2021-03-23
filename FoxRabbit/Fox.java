import java.util.ArrayList;

public class Fox extends Animal {
  
  private int red = 255;
  private int green = 140;
  private int blue = 0;
  private float speed = 50;
  private float size = 6;
  private float interactionRange = 50;
  private float interactionSpeed = 10;
  
  private double reproductionRate = 70;
  private int numberOfChildren = 1;
  
  private double consumptionRate = 30;
  
  private double starvationTime = 50;
  private double starvationProbability = 100;
  
  private double timeSinceEaten;
  
  
  
  
  public Fox() {
    this(0,0);
  }
  
  public Fox(float xPos, float yPos) {
    super(xPos, yPos); 
    this.setColor(red, green, blue);
    this.setSize(size);
    this.setSpeed(speed);
    this.setInteractionRange(interactionRange);
    this.setInteractionSpeed(interactionSpeed);
    this.setReproductionRate(reproductionRate);
    this.setNumberOfChildren(numberOfChildren);
    
    timeSinceEaten = 0;
  }
  
  @Override
  public void behave(ArrayList<Animal> nearbyAnimals, double dt) {
    if (this.isAlive()) {

        this.hunt(nearbyAnimals, dt);
      this.updateAge(dt);
   //   if (tryReproduction()) {
   //     this.reproduceAttempt(this.getClass(), dt);
   //   } 
      if (dies(dt)) {
        this.kill(); 
      }
      this.travel(dt);
      timeSinceEaten = timeSinceEaten + dt;
    }
    
  }
  
  private boolean dies(double dt) {
    if (timeSinceEaten >= starvationTime) {
      double dice = this.roleDice();
      if (starvationProbability*dt > dice) {
        return true;
      }
    }
    return false;
  
  }
  
  private boolean tryReproduction() {
    return timeSinceEaten <= 0;
  }
  
  private static int deadRabbit = 0;
  
  private void hunt(ArrayList<Animal> nearbyAnimals, double dt) {
    for (int i = 0; i < nearbyAnimals.size() && timeSinceEaten > 0; i++) {
      Animal a =  nearbyAnimals.get(i);
      if (a.getClass() == Rabbit.class && a.isAlive()) {
        double dice = this.roleDice();
        if (consumptionRate*dt > dice) {
          a.kill(); 
          timeSinceEaten = 0;
          this.reproduceAttempt(this.getClass(), dt);
        }
      }
    }
  }
  

  
  
}
