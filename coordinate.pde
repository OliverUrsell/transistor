class coordinate {
  int x,y;
  int finalX, finalY;
  
  Component partOf;
  boolean powered; //true if this coordinate is a power source
  boolean connectedToPower; //True if this is connected somehow to a power source
  boolean state; //true if this coordinate is powered by any means
  
  ArrayList<wire> connectedWires = new ArrayList<wire>();
  
  coordinate(int _x,int _y, boolean _powered, Component _partOf){
    x = _x;
    y = _y;
    powered = _powered;
    state = _powered;
    partOf = _partOf;
  }
  
  void draw(int[] windowCenter, int componentX, int componentY){
    strokeWeight(20);
    finalX = windowCenter[0] + componentX + x; //TODO: optimise this so the variable is only recalculated when nessercary
    finalY = windowCenter[1] + componentY + y; //TODO: optimise this so the variable is only recalculated when nessercary
    
    
    //If the pin is high, it should be green. Low it should be red
    //provided the mouse is not inside it or a wire is currently being drawn between it and another node
    if(state){
      stroke(0,255,0);
    }else{
      stroke(255,0,0);
    }
    
    
    
    if((finalX-mouseX)*(finalX-mouseX) + (finalY-mouseY)*(finalY-mouseY) <= 10*10) {
      //The mouse is within the radius of the circle
      
      stroke(0,255,255);
      
      if(mousePressed && mouseButton == RIGHT){
        //Check to see if a line is being drawn
        if(lineStarted == false){
          lineStart = this;
          lineStarted = true;
        }else{
          if(lineStart != this){
            currentHover = this;
          }
        }
      }
    }else{
      //the mouse is not within the circle
      if(currentHover == this){
        currentHover = null;
      }
      
    }
    
    if(lineStart == this){
      stroke(255, 255, 0);
    }
    
    
    point(finalX, finalY);
    stroke(0);
  }
}
