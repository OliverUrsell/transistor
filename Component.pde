class Component {
  //Parent class for the components you can place in the logic window
  int x, y, Width, Height;
  PImage img;
  ArrayList<coordinate> connections = new ArrayList<coordinate>();
  
  void draw(int[] windowCenter){
    fill(0);
    image(img, windowCenter[0] + x, windowCenter[1] + y, Width, Height);
    for(coordinate c:connections){
      c.draw(windowCenter, x, y);
    }
    performLogic();
  }
  
  void resetConnected(){
    //Set the state of all coordinates this component is connected to to false.
    //Used when we're updating the state of one of our components
    for(coordinate coord: connections){
      for(wire w:coord.connectedWires){
        coordinate other = w.getOtherCoord(coord);
        if(other.partOf instanceof Switch){
          other.partOf.reset();
        }
        other.partOf.performLogic();
      }
    }
  }
  
  void reset(){
    //Called whenever one of the coordinates attached to this component is reset, overwritten by child classes
  }
  
  boolean performLogic(){
    //Overrided by the children of this class, so they can do their own logic on their components.
    //returns true if something changes, false if not
    return false; //return false nothing has changed
  }
  
  void activate(){
    //Activated when the space key is pressed whilst the mouse is over this component
    //overriden by some children (e.g the switch so you can toggle it)
  }
}
