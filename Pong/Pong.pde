Ball one = new Ball(400, 300, 1, 10);

void setup(){
  frameRate(60);
  size(960, 540);
}

void draw(){
  background(0);
  one.display();
  one.moveBall();
}


static final int FPS = 60;
