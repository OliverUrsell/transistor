class componentsBar{
  
  void setup(){
    Component[] allTypes = {new True(0,0), new Transistor(0,0)}; //All the component types to display
  }
  
  void draw(){
    fill(200);
    stroke(0);
    strokeWeight(10);
    rect(0,0, width/8, height);
  }
  
}
