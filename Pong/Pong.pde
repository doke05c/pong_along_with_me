public int leftScore = 0;
public int rightScore = 0;

public void displayScore() {
  textSize(xSize/20);
  text(leftScore, xSize/2 - xSize/16, ySize/10); 
  text(rightScore, xSize/2 + xSize/16, ySize/10); 
}


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
  size(/*960,540);*/1280, 720);
}
  
Ball ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
Paddle leftPaddle = new Paddle(paddleOffset-(xSize/80), ySize/2, xSize/80, ySize/12);
Paddle rightPaddle = new Paddle(xSize-paddleOffset, ySize/2, xSize/80, ySize/12);


void draw(){
  background(0);
  if (ball.getX() < leftPaddleLocation+ball.getRadius()/2) {
    ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
    ball.display();
    rightScore++;
  } else if (ball.getX() > rightPaddleLocation-ball.getRadius()/2) {
    ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
    ball.display();
    leftScore++;
  } else {
    ball.display();
  }
  
  leftPaddle.display();
  rightPaddle.display();
  displayScore();
  ball.moveBall();
}


static final int FPS = 60;
static final int xSize = /*960;*/1280;
static final int ySize = /*540;*/720;
static final double ballSpeed = xSize/(2.133333*FPS);

static final int paddleOffset = xSize/32;

static final int rightSideUpperAngle = 388;
static final int rightSideLowerAngle = 332;
static final int rightPaddleLocation = xSize - paddleOffset;

static final int leftSideUpperAngle = 208;
static final int leftSideLowerAngle = 152;
static final int leftPaddleLocation = paddleOffset;
