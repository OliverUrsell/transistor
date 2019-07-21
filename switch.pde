class Switch extends Component{
  
  coordinate in;
  coordinate out;
  PImage openimg;
  PImage closedimg;
  boolean closed = true;
  
  Switch(int _x, int _y){
    x = _x;
    y = _y;
    Width = 125;
    Height = 60;
    in = new coordinate(0,51,false,this);
    out = new coordinate(125,51,false,this);
    connections.add(in);
    connections.add(out);
    openimg = loadImage("switch/open.png");
    closedimg = loadImage("switch/closed.png");
    if(closed){ img = closedimg; }else{ img = openimg; }
  }
  
  @Override public void draw(int[] windowCenter){
    super.draw(windowCenter);
    //print("True");
  }
  
  @Override boolean performLogic(){
    //if(closed && (in.state || out.state)){
    //  if(in.state && out.state){
    //    return false; //nothing has changed
    //  }else{
    //    in.state = true;
    //    out.state = true;
    //    resetConnected();
    //    return true;
    //  }
    //}else if(!closed){
    //  //switch is open
    //  if(in.state && out.state){
    //    in.state = false;
    //    out.state = false;
    //    resetConnected();
    //    return true;
    //  }
    //  return false;
    //}else{ //neither sides are 1, both are definetly 0
    //  return false; //nothing has changed
    //}
    
    if(in.state){
      if(closed){
        if(out.state){
          return false; //return false nothing has changed
        }else{
          out.state = true;
          return true; //return true something has changed
        }
      }else{
        if(out.state){
          out.state = false;
          resetConnected();
          return true; //return true something changed
        }else{
          return false; //return false nothing changed
        }
      }
    }else if(out.state){
      if(closed){
        if(in.state){
          return false; //return false nothing has changed
        }else{
          in.state = true;
          return true; //return true something has changed
        }
      }else{
        if(in.state){
          in.state = false;
          resetConnected();
          return true; //return true something changed
        }else{
          return false; //return false nothing changed
        }
      }
    }else{
      return false;
    }
  }
  
  @Override void activate(){
    closed = !closed;
    if(closed){ img = closedimg; }else{ img = openimg; }
    resetConnected();
  }
  
  @Override void reset(){
    in.state = false;
    out.state = false;
  }
  
}
