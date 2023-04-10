
public double determineAngle() {
  double result;
  double randomAngleLeft = Math.random() * (leftSideUpperAngle - leftSideLowerAngle + 1) + leftSideLowerAngle;
  double randomAngleRight = Math.random() * (rightSideUpperAngle - rightSideLowerAngle + 1) + rightSideLowerAngle;
  if (Math.random() < 0.5) {
    result = randomAngleLeft;
  } else {
    result = randomAngleRight;
  }
  return result;
}

void setup(){
  frameRate(FPS);
  size(1280, 720);
}
  
Ball one = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());

void draw(){
  background(0);
  if (one.getX() < leftPaddleLocation) {
    one = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
    one.display();
    //add score mechanism, give point to right side
  
  } else if (one.getX() > rightPaddleLocation) {
    one = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
    one.display();
    //add score mechanism, give point to left side
    
  } else {
    one.display();
  }
  one.moveBall();
}


static final int FPS = 60;
static final int xSize = 1280;
static final int ySize = 720;
static final int ballSpeed = 10;

static final int paddleOffset = 40;

static final int rightSideUpperAngle = 390;
static final int rightSideLowerAngle = 330;
static final int rightPaddleLocation = xSize - paddleOffset;

static final int leftSideUpperAngle = 210;
static final int leftSideLowerAngle = 150;
static final int leftPaddleLocation = paddleOffset;
