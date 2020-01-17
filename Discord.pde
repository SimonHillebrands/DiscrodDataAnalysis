import java.io.*; 
import java.io.FileReader;
import java.util.Iterator;
import java.util.AbstractMap;
import java.util.Map;
import java.util.Map.Entry;
import controlP5.*;
import grafica.*;
import java.util.Set;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;




public int Normalize(int n){
  return(  (width)*(n-100)/(21000-100));
}




public void GraphTotals(Database data,int dir){
  
  int j = 20;
  int i = 0;
  Map<String, Message> map = data.sortBySize(dir); 
  for (Map.Entry<String, Message> en : map.entrySet()) {
    String name = data.getName(en.getKey());
    int val = en.getValue().Length();    
    rects[i].newRect(0,j,Normalize(val),20,name,val);
    //rect(0,j,Normalize(val),20);
    fill(255,255,255);
    text(name + "    " + val,0,j+15);
    i++;
    j+=20;
  }
}
public void GraphWords(Database data,int dir){
  
  int j = 20;
  int i = 0;
  Map<String, Integer> map = data.sortByWords(dir); 
  for (Map.Entry<String,Integer > en : map.entrySet()) {
    String name = en.getKey();
    int val = en.getValue();    
    rects[i].newRect(0,j,Normalize(val),20,name,val);
    //rect(0,j,Normalize(val),20);
    fill(255,255,255);
    text(name + "    " + val,0,j+15);
    i++;
    j+=20;
  }
}

ControlP5 panel;
ControlP5 cp5;
Database data;
Rect[] rects;
void setup(){
  size(900,800);
  rects = new Rect[100];
  for(int i = 0;i<rects.length;i++){
    rects[i] = new Rect(0,0,0,0,"",0);
  }


  data = new Database();
  GraphTotals(data,-1);
  
  
   cp5 = new ControlP5(this);
  ButtonBar b = cp5.addButtonBar("bar")
     .setPosition(0, 0)
     .setSize(400, 20)
     .addItems(split("a b c"," "));
  b.changeItem("a","text","Word Totals");
  b.changeItem("b","text","Words");
  b.onMove(new CallbackListener(){
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      //println("hello ",bar.hover());
    }
  });
  
}


void bar(int n) {
  clear();
  background(125,125,125);
  if(n ==0)
    GraphTotals(data,-1);
  if(n==1)
    GraphWords(data,-1);
  if(n==2)
    GraphTotals(data,1);
    
}

void draw(){
  clear();
  background(125,125,125);
  noStroke();
  for(int i = 0;i<rects.length;i++){
    fill(125,i,i);
    rects[i].Draw();
  }
}
