import java.io.*; 
import java.io.FileReader;
import java.util.*; 
import java.lang.*; 
import java.util.Objects;
import java.util.Map.Entry;
import java.util.Iterator;
import java.util.Set;


HashMap<String,Entity> grabMessages(){
  String[] index = loadStrings("messages\\index.json");
  index= index[0].split(",");
  HashMap<String,Entity> e = new HashMap<String,Entity>();
  for(int i =0;i<5/*index.length*/;i++){
      String[] s = index[i].split("\"");
      try{
      e.put(s[1],new Entity(s[1],"alpha"));
     // e[i].printAll();
      }catch(NullPointerException f){
        f.printStackTrace();
      }
      
  }
  return e;
}

float scale(int x,int xmin,int xmax){
  return((float)(x-xmin)/(xmax-xmin));
}
Iterator<Entry<Calendar,Integer>> iter;
Entity josh;
float t;
int c;
void setup(){
   try
{
    Thread.sleep(1000);
}
catch(InterruptedException ex)
{
    Thread.currentThread().interrupt();
}

  size(800, 400);
  t = 0;
  c = 0;
  
  HashMap<String,Entity> e = grabMessages();
  // for (Map.Entry<String,Entity> entry : e.entrySet()) {
  //     entry.getValue().calculateWordCount();
  //     entry.getValue().printCount();
  //     println(entry.getValue().toString());
  //}
  josh = e.get("545073786530168832");
  TreeMap<Calendar,Integer> joshTMoT = josh.getTotalMessagesOverTime();
  Set<Entry<Calendar,Integer>> joshTMoTset = joshTMoT.entrySet();
  iter= joshTMoTset.iterator();
}
void draw(){
  int size = josh.getSize(); //<>//
  Map.Entry<Calendar,Integer> m = iter.next();
  int y = m.getValue();
 // println(y);
  //print(m.getKey());
  //print("\t");
  //println(m.getValue());
//  println(scale(y,0,10000));
  textSize(32);
  noStroke();
  fill(125,125,125);
  rect(150,150,80,80);
  fill(255,255,255);
  text(m.getKey().get(Calendar.MONTH),200,200);
  ellipse(t,(float)height*-1*scale(y,0,6000)+(height),5,5);
  t+=4.5;
  
}
