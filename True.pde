class True extends Component{
  
  coordinate point;
  boolean active = true;
  
  True(int _x, int _y){
    x = _x;
    y = _y;
    Width = 25;
    Height = 50;
    point = new coordinate(12,65,true, this);
    connections.add(point);
    img = loadImage("1.png");
  }
  
  @Override public void draw(int[] windowCenter){
    super.draw(windowCenter);
    //print("True");
  }
  
  @Override boolean performLogic(){
    if(active){
      if(point.powered & point.state){
        return false; //return false nothing has changed
      }else{
        point.powered = true;
        point.state = true;
        return true; //return true something has changed
      }
    }else{
      if(point.powered){
        point.powered = false;
        point.state = false;
        resetConnected();
        return true; //return true something changed
      }else{
        return false; //return false nothing changed
      }
    }
  }
  
  @Override void activate(){
    active = !active;
    print(active);
    resetConnected();
  }
  
}
