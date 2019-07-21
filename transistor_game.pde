componentsBar cb = new componentsBar();
LogicWindow lw = new LogicWindow();
Logic logic = new Logic();

void setup(){
  fullScreen();
  cb.setup();
  lw.setup();
  lw.addComponent(new Transistor(-100,100));
  lw.addComponent(new Transistor(0,0));
  lw.addComponent(new Switch(200,200));
  lw.addComponent(new True(0, 100));
}

void draw(){
  background(255);
  lw.draw();
  cb.draw();
  logic.calculate();
}
