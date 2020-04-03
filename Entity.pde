import java.io.*; 
import java.io.FileReader;
import java.io.File;
import java.util.*; 
import java.lang.*; 
import java.util.Objects;

import java.text.ParseException;
import java.text.SimpleDateFormat;  
import java.util.Date;
public class Entity{
  String id;
  String name;
  File file;
  public TreeMap<Date,String>messages;
  public TreeMap<Date,Integer>wordCount;
  
  public Entity(String id, String name){
    this.id=id;
    this.name=name;
    String[] lines = loadStrings("messages\\"+id+"\\messages.csv");
    messages = new TreeMap<Date,String>();
    for(int i= 0;i<lines.length;i++){
      try{
        messages.put(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(lines[i].substring(19,39)),lines[i].substring(52,lines[i].length()-1));
      }catch(ParseException e){
      //  e.printStackTrace();
      }catch(StringIndexOutOfBoundsException e){
        // e.printStackTrace();
      }
    }
   calculateWordCount(); 
  }
  public void calculateWordCount(){
   wordCount = new TreeMap<Date,Integer>();
   
   for (Map.Entry<Date, String> entry : messages.entrySet()) {
      String[] s = entry.getValue().split("\\s");
      wordCount.put(entry.getKey(),s.length);
        }
  }
 public TreeMap<Calendar,Integer> getTotalMessagesOverTime(){
   TreeMap<Calendar,Integer> tot = new TreeMap<Calendar,Integer>();
   int runningTotal = 0;
   for (Map.Entry<Date, String> entry : messages.entrySet()) {
     
      Calendar cal = Calendar.getInstance();
      cal.setTime(entry.getKey());
      cal.set(Calendar.HOUR_OF_DAY, 0);
      cal.set(Calendar.MINUTE, 0);
      cal.set(Calendar.SECOND, 0);
      cal.set(Calendar.MILLISECOND, 0);
      
      runningTotal++;
      tot.put(cal,runningTotal);  
   }
   return tot;
   
 }
 public String getID(){
  return this.id; 
 }
 public void printCount(){
   int total = 0;
   for (Map.Entry<Date, Integer> entry : wordCount.entrySet()) {
      total+=entry.getValue();
   }
   println(total);
 }
 public int getSize(){
    return(messages.size());
 }
 public String toString(){
   String s ="";
   for (Map.Entry<Date, String> entry : messages.entrySet()) {
    s +=(entry.getKey().toString() + "\t" + entry.getValue()) +"\n";
   }
   return s;
 }
}
