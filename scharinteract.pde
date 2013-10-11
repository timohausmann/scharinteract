/*
 * Scharinteract
 * @version 1.0
 * @author Timo Hausmann <hello@timohausmann.de>
 * @licence The MIT License (MIT)
 * @repository https://github.com/timohausmann/scharinteract
 */

/*
 * Parameters
 */
int line_lifetime = 2000; //Lebensdauer einer Linie (in ms)
float degree_delta = 0.5; //Gradaenderung pro Iteration
float line_len_delta = 3; //Groessenaenderung pro Iteration
float line_pos_delta = 1.5; //Positionsaenderung pro Iteration
 
 
/*
 * Runtime Variables
 */
float degree = 0; //aktuelle Gradzahl
ArrayList<Line> lines; //Array fuer unsere Linien


/*
 * setup
 */
void setup() {
  
  size(800, 600);
  
  lines = new ArrayList<Line>();
}


/*
 * draw
 */
void draw() {

  background(224,220,185);
  
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
