import java.util.ArrayList;
import java.util.HashMap;

public class Data {
  
  private ArrayList< HashMap<Class<? extends Animal>, Float>> count;
  private int maxData = 10000;
  
  
  public Data() {
    count = new  ArrayList< HashMap<Class<? extends Animal>, Float>>();
  }
  
  public void updateCount(HashMap<Class<? extends Animal>, Float> current) {
    count.add(current); 
    if(count.size() > 10000) {
      prune();
    }
  }
  
  public void prune() {
    //System.out.println("prune called");
  }
  
  public ArrayList< HashMap<Class<? extends Animal>, Float>> getCount() {
    return count; 
  }
}
