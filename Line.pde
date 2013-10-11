/*
 * class Line
 */
class Line { 
  
  int birth; //Zeitpunkt der Erstellung (in ms)
  int age; //Derzeitige Lebensdaur (in ms)
  float x; //X-Position
  float y; //Y-Position
  float len; //Laenge
  float degree; //Drehung in Grad
  
  /*
   * Line Constructor
   * @param float _x  X-Position
   * @param float _x  Y-Position
   * @param float _degree Drehung in Grad
   */
  Line(float _x, float _y, float _degree) {
    
    birth = millis(); //"Geburtsdatum" festhalten
    x = _x;
    y = _y; 
    len = random(300,400);
    degree = _degree;
  } 
  
  
  /*
   * Line.update
   * Diese Funktion aktualisiert lediglich die Werte der Linie
   */
  void update() {
    
    //Alter aktualisieren
    age = millis() - birth;
    
    //Linienlaenge aktualisieren
    len += line_len_delta;
    
    //Position aktualisieren
    x = x + (sin( radians(degree) ) * line_pos_delta);
    y = y - (cos( radians(degree) ) * line_pos_delta);
  } 
  
  
  /*
   * Line.paint
   * Diese Funktion zeichnet die Linie
   */
  void paint() { 
    
     //Alphawert anhand des Alters bestimmen
     float alpha = map(age, 0,line_lifetime,100,0);
     
     //Da x und y nur den Mittelpunkt der Linie beschreiben, 
     //muessen wir die Linie mithilfe der Gradzahl eine halbe Laenge weitterrechnen.
     //Diese Werte addieren und subtrahieren wir dann pro Achse einmal, 
     //um Start- und Endpunkt zu erhalten.
     float len_x = (cos( radians(degree) ) * (len/2));
     float len_y = (sin( radians(degree) ) * (len/2));
     
     stroke(0,0,0,alpha);
     line(x + len_x, y + len_y, x - len_x, y - len_y);
  }
  
  
  /*
   * Line.isDead 
   * @return boolean true, wenn Lebensdauer der Linie ueberschritten
   */
  boolean isDead() {
    
    //wenn das Alter der Linie hoeher ist, als die definierte Lebensdauer, wird true zurueckgeliefert
    return ( age > line_lifetime );
  }
} 
