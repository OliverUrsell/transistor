boolean lineStarted = false;
coordinate lineStart = null;
coordinate currentHover = null;


class LogicWindow{
  
  ArrayList<Component> components = new ArrayList<Component>();
  
  ArrayList<wire> wires = new ArrayList<wire>();
  
  int[] center = {0, 0};
  Component selected;
  int mouseXtemp;
  int mouseYtemp;
  
  boolean held = false;
  
  void setup(){
    center[0] = 7*width/16 + width/8;
    center[1] = height/2;
    mouseXtemp = mouseX;
    mouseYtemp = mouseY;
  }
  
  void draw(){
    fill(255);
    stroke(0);
    strokeWeight(10);
    rect(width/8, 0, 7*width/8, height);
    
    //Set the state of every component to false, so that the powered nodes can be figured out correctly
    for(Component c:components){
      c.draw(center);
    }
    
    if(mousePressed && mouseButton == CENTER){
      center[0] += mouseX - mouseXtemp;
      center[1] += mouseY - mouseYtemp;
    }
    
    if(mousePressed && mouseButton == LEFT && selected == null){
      for(Component c:components){
        if(mouseX >= c.x + center[0] && mouseX <= c.x + center[0] + c.Width){
          if(mouseY >= c.y + center[1] && mouseY <= c.y + center[1] + c.Height){
            c.x += mouseX - mouseXtemp;
            c.y += mouseY - mouseYtemp;
            selected = c;
            break;
          }
        }
      }
    }else if(selected != null){
      selected.x += mouseX - mouseXtemp;
      selected.y += mouseY - mouseYtemp;
    }
    
    if(selected != null && (mousePressed == false || mouseButton != LEFT)){
      selected = null;
    }
    
    if(keyPressed && (key == BACKSPACE || key == DELETE)){
      for(Component c:components){
        if(mouseX >= c.x + center[0] && mouseX <= c.x + center[0] + c.Width){
          if(mouseY >= c.y + center[1] && mouseY <= c.y + center[1] + c.Height){
            removeComponent(c); //delete the component
            break;
          }
        }
      }
    }
    
    if(keyPressed && key == ' ' && !held){
      held = true;
      for(Component c:components){
        if(mouseX >= c.x + center[0] && mouseX <= c.x + center[0] + c.Width){
          if(mouseY >= c.y + center[1] && mouseY <= c.y + center[1] + c.Height){
            c.activate();
            break;
          }
        }
      }
    }else{
      if(!keyPressed || key != ' '){
        held = false;
      }
    }
    
    mouseXtemp = mouseX;
    mouseYtemp = mouseY;
    
    wire wireToDelete = null; //Keep track of any wires which may be deleted
    //Draw all of the wires
    for(wire w: wires){
      if(w.draw() == false){
        wireToDelete = w;
      }
    }
    if (wireToDelete != null){
      deleteWire(wireToDelete);
      wireToDelete = null;
    }
    
    if(lineStarted && (mousePressed == false || mouseButton != RIGHT)){
      //The line has finished
      if(lineStart != null && currentHover != null && lineStart.partOf != currentHover.partOf){ //TODO: make it so you can connect two coordinates that are part of one component
        addNewWire(new wire(lineStart, currentHover));
      }
      lineStart = null;
      currentHover = null;
      lineStarted = false;
    }
    //calculateCoordinateState();
  }
  
  boolean addComponent(Component c){
    components.add(c);
    return true;
  }
  
  boolean removeComponent(Component comp){
    for(coordinate c:comp.connections){
      ArrayList<wire> tempArray = new ArrayList<wire>();
      for(wire w:c.connectedWires){
        tempArray.add(w);
      }
      for(wire w:tempArray){
        try{
          deleteWire(w);
        }catch(Exception e){
          print("We are trying to delete one of the wires more than once");
        }
      }
    }
    components.remove(comp);
    return true;
  }
  
  void addNewWire(wire w){
    wires.add(w);
    w.startCoordinate.connectedWires.add(w);
    w.finishCoordinate.connectedWires.add(w);
  }
  
  void deleteWire(wire w){
    for(wire w2:wires){
      w2.startCoordinate.state = false;
      w2.finishCoordinate.state = false;
    }
    w.startCoordinate.connectedWires.remove(w);
    w.finishCoordinate.connectedWires.remove(w);
    wires.remove(w);
  }
  
  void calculateCoordinateState(){
    //Calculates the state of every coordinate in the window
    
    ArrayList<coordinate> coords = new ArrayList<coordinate>();
    
    for(Component comp: components){
      for(coordinate c: comp.connections){
        c.powered = false;
        c.state = false;
        coords.add(c);
      }
      comp.performLogic();
    }
    
    boolean warning = false;
    while(true){
      coordinate toRemove = null;
      for(coordinate c:coords){
        if(c.powered){
          c.state = true;
          c.partOf.performLogic();
          if(c.powered == true){
            for(wire w:c.connectedWires){
              coordinate other = w.getOtherCoord(c);
              other.state = true;
              other.partOf.performLogic();
              toRemove = c;
            }
          }
        }
      }
      if(toRemove == null){
        //All the powered nodes have been processed
        for(coordinate c:coords){
          c.partOf.performLogic();
          if(c.state){
            for (wire w:c.connectedWires){
              coordinate other = w.getOtherCoord(c);
              other.state = true;
              other.partOf.performLogic();
            }
          }
        }
        if(warning){
          break;
        }else{
          warning = true;
        }
      }else{
        coords.remove(toRemove);
        warning = false;
      }
    }
  }
}
