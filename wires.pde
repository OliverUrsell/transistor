class wire{
  coordinate startCoordinate;
  coordinate finishCoordinate;
  
  int radius = 10;
  
  wire(coordinate sc, coordinate fc){
    startCoordinate = sc;
    finishCoordinate = fc;
    draw();
  }
  
  boolean draw(){
    //returns true normally, if returns false, the wire is deleted by the logic window
    strokeWeight(radius);
    if(startCoordinate.state || finishCoordinate.state){
      stroke(0,255,0);
    }else{
      stroke(255,0,0);
    }
    
    if(pointInLine(mouseX, mouseY)){
      stroke(0, 255, 255);
      if(keyPressed && (key == BACKSPACE || key == DELETE)){
        //If the delete key has been pressed and the mouse is over this wire delete this wire.
        print("Here");
        return false;
      }
    }
    
    line(startCoordinate.finalX, startCoordinate.finalY, finishCoordinate.finalX, finishCoordinate.finalY);
    
    //if(startCoordinate.state || finishCoordinate.state){
    //  startCoordinate.state = true;
    //  finishCoordinate.state = true;
    //}else{
    //  startCoordinate.state = false;
    //  finishCoordinate.state = false;
    //}
    
    return true;
  }
  
  coordinate getOtherCoord(coordinate otherThan){
    //Returns the other coordinate this wire is connected to.
    if(otherThan.equals(startCoordinate)){
      return finishCoordinate;
    }else if(otherThan.equals(finishCoordinate)){
      return startCoordinate;
    }else{
      //The specified coordinate is neither of the coordinates so return null
      return null;
    }
  }
  
  boolean pointInLine(int _x, int _y){
    if(_x >= min(startCoordinate.finalX, finishCoordinate.finalX) - radius && _x <= max(startCoordinate.finalX, finishCoordinate.finalX) + radius){
      float validy = 1; //temp value to avoid compiler errors
      if(finishCoordinate.finalX - startCoordinate.finalX != 0){
        validy = ((finishCoordinate.finalY - startCoordinate.finalY)/(finishCoordinate.finalX - startCoordinate.finalX))*(_x - startCoordinate.finalX) + startCoordinate.finalY;
        if( _y >= validy - radius*2 && _y <= validy + radius*2){
          return true;
        }
      }else{
        return true;
      }
    }
    
    return false;
  }
}
