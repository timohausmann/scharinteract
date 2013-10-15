/*
 * Scharinteract
 * @version 1.0
 * @author Timo Hausmann <hello@timohausmann.de>
 * @licence The MIT License (MIT)
 * @repository https://github.com/timohausmann/scharinteract
 */
 
 
/*
 * GUI Controls
 */
import controlP5.*;
ControlP5 cp5;
Toggle toggleBlackWhite;
Slider slideLifetime;
Slider slideDegree;
Slider slideLen;
Slider slidePos;


/*
 * Parameters
 */
int line_lifetime = 2000; //Lebensdauer einer Linie (in ms)
float degree_delta = 0.5; //Gradaenderung pro Iteration
float line_len_delta = 3; //Groessenaenderung pro Iteration
float line_pos_delta = 1.5; //Positionsaenderung pro Iteration
boolean black_and_white = false; //schwarzweiss Modus
 
 
/*
 * Runtime Variables
 */
float degree = 0; //aktuelle Gradzahl
ArrayList<Line> lines; //Array fuer unsere Linien


/*
 * setup
 */
void setup() {
  
  size(displayWidth, displayHeight, P2D);
  //size(800, 600, P2D);
  smooth();
  
  lines = new ArrayList<Line>();
  
  
  /*
   * GUI Controls
   */
  cp5 = new ControlP5(this);
  
  toggleBlackWhite = cp5.addToggle("black_and_white")
     .setCaptionLabel("Schwarzweiß")
     .setColorLabel(color(10,20,30,140))
     .setPosition(20,20)
     .setSize(50,20)
     .setValue(false)
     .setMode(ControlP5.SWITCH);
     
  slideLifetime = cp5.addSlider("line_lifetime")
     .setCaptionLabel("Lebensdauer (ms)")
     .setColorLabel(color(10,20,30,140))
     .setPosition(20,60)
     .setSize(100,20)
     .setValue(2000)
     .setRange(100,4000);
     
  slideDegree = cp5.addSlider("degree_delta")
     .setCaptionLabel("Drehungsstaerke")
     .setColorLabel(color(10,20,30,140))
     .setPosition(20,90)
     .setSize(100,20)
     .setValue(0.5)
     .setRange(0,2.5);
     
  slidePos = cp5.addSlider("line_pos_delta")
     .setCaptionLabel("Bewegungsstaerke")
     .setColorLabel(color(10,20,30,140))
     .setPosition(20,120)
     .setSize(100,20)
     .setValue(3)
     .setRange(0,5);  
     
  slideLen = cp5.addSlider("line_len_delta")
     .setCaptionLabel("Wachstumsstaerke")
     .setColorLabel(color(10,20,30,140))
     .setPosition(20,150)
     .setSize(100,20)
     .setValue(0.5)
     .setRange(-5,5);
     
  cp5.addButton("resetValues")
     .setPosition(20,190)
     .setSize(100,30)
     .setCaptionLabel("Werte zuruecksetzen");
     
}


/*
 * draw
 */
void draw() {

  background(255,255,255);
  
  //degree laeuft von 0 bis endlos.
  degree += degree_delta;
  
  //Neue Linie an Position mouseX, mouseY mit gegebener Drehung erstellen.
  //sin(radians(degree)) pendelt zwischen -1 und 1 hin und her; durch die *360 schliesslich zwischen -360 und +360. 
  //Mit der 45 wird dafuer gesorgt, dass die Endstellungen des Pendelns diagonal sind, also -315 und +405
  lines.add( new Line(mouseX, mouseY, 45 + (sin(radians(degree)) * 360)) );
    
  //ueber alle Linien loopen ...
  for(int i=0;i<lines.size();i++) {
    
    Line currLine = lines.get(i);
    
    //Linie aktualisieren und malen (s.u.)
    currLine.update();
    currLine.paint();
    
    //"tote" Linien aus dem Array loeschen
    if( currLine.isDead() ) {
      lines.remove(i);
    }
  }
}




public void resetValues(int theValue) {
  
  toggleBlackWhite.setValue(false);
  slideLifetime.setValue(2000);
  slideDegree.setValue(0.5);
  slideLen.setValue(3);
  slidePos.setValue(1.5);
}
