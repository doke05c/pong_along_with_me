Ball one = new Ball(400, 300, 1, 0);
Ball two = new Ball(400, 300, 1, 45);
Ball three = new Ball(400, 300, 1, 90);

void setup(){
  frameRate(60);
  size(960, 540);
}

void draw(){
  background(0);
  //one.display();
  //one.moveBall();
  
  two.display();
  two.moveBall();
  
  three.display();
  three.moveBall();
}


static final int FPS = 60;
