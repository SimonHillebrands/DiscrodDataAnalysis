import java.io.*; 
import java.io.FileReader;
import java.util.*; 
import java.lang.*; 
import java.util.Objects;
import java.util.Map.Entry;
import java.util.Iterator;
import java.util.Set;
import grafica.*;

//Make a hashmap of entitys and their respective string IDs
HashMap<String,Entity> grabMessages(){
  String[] index = loadStrings("messages\\index.json");
  index= index[0].split(",");
  HashMap<String,Entity> e = new HashMap<String,Entity>();
  for(int i =0;i<index.length;i++){
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

//Scales number between 0 and 1
float scale(int x,int xmin,int xmax){
  return((float)(x-xmin)/(xmax-xmin));
}
//Fills gpointsarray with values 
GPointsArray populateArray(GPointsArray points,Iterator<Entry<Calendar,Integer>> iter,int size,int delta){
  
  if(delta ==0){ //<>//
    while(iter.hasNext()){
      try{
      Map.Entry<Calendar,Integer> m = iter.next();
      //Gets the time in milliseconds since the epoch
      long x = m.getKey().getTime().getTime();
      int y = m.getValue();
      points.add(x,y,m.getKey().getTime().toString()+","+y);
      }catch(NoSuchElementException f){
        println("oopsie theres no element uwu");
      }
    }
  }if(delta ==1){
     Map.Entry<Calendar,Integer> prev = null;
     while(iter.hasNext()){
      try{
      Map.Entry<Calendar,Integer> m = iter.next();
      //Gets the time in milliseconds since the epoch
      long x = m.getKey().getTime().getTime();
      int y = m.getValue();
      if(prev == null){
        points.add(x,0,m.getKey().getTime().toString());
      }else{
        points.add(x,y-prev.getValue(),m.getKey().getTime().toString());
      }
      prev = m;
      }catch(NoSuchElementException f){
        println("oopsie theres no element uwu");
      }
      
    }
    
  }
    return points;
  
}
Iterator<Entry<Calendar,Integer>> iterJ;
Iterator<Entry<Calendar,Integer>> iterS;
Iterator<Entry<Calendar,Integer>> iterWC;

Entity josh;
Entity simon;
float t;
int c;
GPlot totalWordsOverTimePlot;
void setup(){
   try
{
    Thread.sleep(1000);
}
catch(InterruptedException ex)
{
    Thread.currentThread().interrupt();
}

  size(1200, 500);
  t = 0;
  c = 0;
  //The toal word over time plot and setup
  totalWordsOverTimePlot = new GPlot(this);
  totalWordsOverTimePlot.activatePanning();
  GPointsArray pointsJosh = new GPointsArray();
  GPointsArray pointsSimon = new GPointsArray();
  GPointsArray points = new GPointsArray();

  //all of the Entity() objects
  HashMap<String,Entity> e = grabMessages();
  // for (Map.Entry<String,Entity> entry : e.entrySet()) {
  //     entry.getValue().calculateWordCount();
  //     entry.getValue().printCount();
  //     println(entry.getValue().toString());
  //}
  //josh
  josh = e.get("545073786530168831");
  simon = e.get("545073786530168832");
  //create a a treemap and setup the iterator
  TreeMap<Calendar,Integer> joshTMoT = josh.getTotalMessagesOverTime();
  Set<Entry<Calendar,Integer>> joshTMoTset = joshTMoT.entrySet();
  iterJ= joshTMoTset.iterator();
  
  TreeMap<Calendar,Integer> simonTMoT = simon.getTotalMessagesOverTime();
  Set<Entry<Calendar,Integer>> simonTMoTset = simonTMoT.entrySet();
  iterS= simonTMoTset.iterator();
  
   TreeMap<Calendar,Integer> wordC = simon.getTotalWordsOverTime();
  Set<Entry<Calendar,Integer>> wordCset = wordC.entrySet();
  iterWC= wordCset.iterator();
  points = populateArray(points,iterWC,0,0);
  
  pointsJosh = populateArray(pointsJosh,iterJ,josh.getSize(),1);
  pointsSimon = populateArray(pointsSimon,iterS,simon.getSize(),1);
  
  
 // totalWordsOverTimePlot.addLayer("simon");
//totalWordsOverTimePlot.addLayer("josh");
totalWordsOverTimePlot.addPoints(pointsSimon);
 // totalWordsOverTimePlot.addLayer("josh",pointsJosh);
 // totalWordsOverTimePlot.addLayer("simon",pointsSimon);
 // totalWordsOverTimePlot.setPointSize(0);
  totalWordsOverTimePlot.drawGridLines(GPlot.BOTH);
  totalWordsOverTimePlot.setDim(1000,400);
  totalWordsOverTimePlot.activatePointLabels();
  totalWordsOverTimePlot.drawLabels();
  totalWordsOverTimePlot.getXAxis().setTickLabels(josh.getKeys());
  totalWordsOverTimePlot.defaultDraw();
}
void draw(){
  background(150,150,151); //<>//
 // println(y);
  //print(m.getKey());
  //print("\t");
  //println(m.getValue());
//  println(scale(y,0,10000));

  totalWordsOverTimePlot.beginDraw();
  totalWordsOverTimePlot.drawBox();
  totalWordsOverTimePlot.drawLabels();
  totalWordsOverTimePlot.drawXAxis();
  totalWordsOverTimePlot.drawYAxis();
  totalWordsOverTimePlot.drawTitle();
  totalWordsOverTimePlot.drawPoints();
  totalWordsOverTimePlot.drawLines();
  totalWordsOverTimePlot.endDraw();




  //textSize(32);
  //noStroke();
  //fill(125,125,125);
  //rect(150,150,80,80);
  //fill(255,255,255);
  //text(m.getKey().get(Calendar.MONTH),200,200);
  //ellipse(t,(float)height*-1*scale(y,0,20000)+(height),5,5);
  //t+=2.5;
  
}
