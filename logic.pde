class Logic{
 
  void calculate(){
    //Sets the state of all the coordinates
    boolean again = true;
    //for(Component comp:lw.components){
    //  for(coordinate c: comp.connections){
    //    if(c.powered){
    //      c.state = true;
    //    }
    //  }
    //}
    while(again){
      for(Component comp:lw.components){
        for(coordinate c: comp.connections){
          if(c.powered){
            c.state = true;
          }
          again = false;
          again = c.partOf.performLogic();
          for(wire w:c.connectedWires){
            if(w.getOtherCoord(c).state == true){c.state = true;}
            if(c.partOf.performLogic() || w.getOtherCoord(c).partOf.performLogic()){
              again = true;
            }
          }
        }
      }
    } 
  }
}
