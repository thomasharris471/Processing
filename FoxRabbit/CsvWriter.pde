import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;

public class CsvWriter {
  
  FileWriter writer; 
  
  public CsvWriter(String f) {
   try {  
    writer = new FileWriter(f); 
    writer.append("time");
    writer.append(",");
    writer.append("Fox");
    writer.append(",");
    writer.append("Rabbit");
    writer.append("\n");
   }  catch (FileNotFoundException e) {
      System.out.println(e.getMessage());
    } catch (IOException e) {
      System.out.println(e.getMessage());
    }
  }

  
  public void write(double time, float fox, float rabbit) {

    try {
        writer.append(Double.toString(time));
        writer.append(",");
        writer.append(Float.toString(fox));
        writer.append(",");
        writer.append(Float.toString(rabbit));
        writer.append("\n");
        writer.flush();
       // writer.close();
    } catch (IOException e) {
        System.out.println(e.getMessage());
      }

  

  }
  
}
