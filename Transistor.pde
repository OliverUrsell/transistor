class Transistor extends Component{
  
  coordinate in = new coordinate(79,0,false,this);
  coordinate out = new coordinate(79,100,false,this);
  coordinate enable = new coordinate(0,50,false,this);
  
  Transistor(int _x, int _y){
    x = _x;
    y = _y;
    Width = 100;
    Height = 100;
    connections.add(in);
    connections.add(out);
    connections.add(enable);
    img = loadImage("transistor.png");
  }
  
  @Override public void draw(int[] windowCenter){
    super.draw(windowCenter);
    //print("transistor");
  }
  
  @Override boolean performLogic(){
    if(in.state && enable.state){
      if(out.state){
        return false; //return false nothing has changed
      }else{
        out.state = true;
        //resetConnected();
        return true; //return true something has changed
      }
    }else{
      if(!out.state){
        return false; //return false nothing has changed
      }else{
        out.state = false;
        resetConnected();
        return true; //return true something has changed
      }
    }
  }
}
