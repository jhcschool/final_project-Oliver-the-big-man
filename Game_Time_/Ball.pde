class Ball {
  PVector position;
  int diameter;
  int red;
  int green;
  int blue;
  
  void run(){
    fill(red, green, blue);
    ellipse (position.x, position.y, diameter, diameter);
  }
  
  
}
