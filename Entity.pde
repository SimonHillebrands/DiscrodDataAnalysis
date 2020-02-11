import java.io.*; 
import java.io.FileReader;
import java.io.File;
import java.util.*; 
import java.lang.*; 
import java.util.Objects;


public class Entity{
  String id;
  String name;
  File file;
  public final ArrayList<Map<String,Integer>>words;
  
  public Entity(String id, String name){
    this.id=id;
    this.name=name;
    String currentDir = System.getProperty("user.dir");
    file = new File(currentDir+"\\messages\\"+id);
  }
  
 // String[] index = loadStrings("Discord_Data_Package\\messages\\index.json");
  
  
  
}
