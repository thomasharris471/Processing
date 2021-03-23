  import java.util.ArrayList;

  
  public class VisibleAnimals implements Comparable<VisibleAnimals> {
       private Animal head;
       private ArrayList<Animal> visible;
       
       VisibleAnimals(Animal head, ArrayList<Animal> visible) {
         this.head = head;
         this.visible = visible;
       }
       
       public Animal getHead() {
           return this.head; 
       }
       
       public ArrayList<Animal> getVisible() {
         return this.visible; 
       }
       
       @Override     
  public int compareTo(VisibleAnimals candidate) {   
    Animal h = this.getHead();
    Animal o = candidate.getHead();
    int hs = (int) h.getInteractionSpeed();
    int os = (int) o.getInteractionSpeed();
    return os - hs;
  }       

  }
