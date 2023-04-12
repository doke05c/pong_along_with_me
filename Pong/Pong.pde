//score variables
public int leftScore = 0;
public int rightScore = 0;

//set initial state of ball
int ballState = RUNNING;

//booleans for paddle movement check
public boolean leftUp = false;
public boolean leftDown = false;
public boolean rightUp = false; 
public boolean rightDown = false; 

//display score on screen
public void displayScore() {
  textSize(xSize/20);
  text(leftScore, xSize/2 - xSize/16 - xSize/20, ySize/10); 
  text(rightScore, xSize/2 + xSize/16, ySize/10); 
}

//figure out what angle to reflect ball against paddle at
public double getPaddleAngle(Ball ball, double topHitbox, double bottomHitbox) {
  double hitboxSize = bottomHitbox - topHitbox;
  double ballPercentofHitboxHeight = (ball.getY() - topHitbox)/hitboxSize;
  return ((ballPercentofHitboxHeight * 90) - 45);
}

//determine where the spawning ball should head
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

//instantiate our objects
Ball ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
Paddle leftPaddle = new Paddle(paddleOffset-(xSize/80), ySize/2-ySize/20, xSize/80, ySize/10);
Paddle rightPaddle = new Paddle(xSize-paddleOffset, ySize/2-ySize/20, xSize/80, ySize/10);


//every tick
void draw(){
  background(0);

  //how much leeway can we give the player for paddle reflects in yDimension?
  double paddlePity = (Math.sin((ball.getAngle()/28.6479)-45.5531)+1)*3*ballSpeed+8;
  
  //where is each end of the paddle yDimension hitbox?
  double topLeftPaddleHitbox = leftPaddle.getY()-ball.getRadius()/2-paddlePity;
  double bottomLeftPaddleHitbox = leftPaddle.getY()+leftPaddle.getYDimension()+ball.getRadius()/2+paddlePity;
  double topRightPaddleHitbox = rightPaddle.getY()-ball.getRadius()/2-paddlePity;
  double bottomRightPaddleHitbox = rightPaddle.getY()+rightPaddle.getYDimension()+ball.getRadius()/2+paddlePity;
  
  //determination of points: if ball hits a paddle, reflect. if ball misses paddle, mark it for reset
  if (ballState == RUNNING) {
    if (ball.getX() < leftPaddleEdgeXLocation+ball.getRadius()/2) {
      if ((ball.getY() < topLeftPaddleHitbox) || (ball.getY() > bottomLeftPaddleHitbox)) {
        ballState = MISSINGLEFT;
      } else {
        ball.reflectPaddle(getPaddleAngle(ball, topLeftPaddleHitbox, bottomLeftPaddleHitbox));
      }

    } else if (ball.getX() > rightPaddleEdgeXLocation-ball.getRadius()/2) {
      if ((ball.getY() < topRightPaddleHitbox) || (ball.getY() > bottomRightPaddleHitbox)) {
        ballState = MISSINGRIGHT;
      } else {
        ball.reflectPaddle(180-getPaddleAngle(ball, topRightPaddleHitbox, bottomRightPaddleHitbox));
      }
    }
  }
  
  //when the ball is marked for reset, make it go to the end of the screen. once that is done, reset it.
  if (ballState == MISSINGLEFT) {
    if (ball.getX()+ball.getRadius() > (-(xSize/3))) {ball.moveBallTick();}
    else {ballState = RESETTINGLEFT;}
  }
  if (ballState == MISSINGRIGHT) {
    if (ball.getX()+ball.getRadius() < (xSize+(xSize/3))) {ball.moveBallTick();}
    else {ballState = RESETTINGRIGHT;}
  }
  
  //resetting the ball
  if (ballState == RESETTINGLEFT) {
    ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
    rightScore++;
    ballState = RUNNING;
  }
  if (ballState == RESETTINGRIGHT) {
    ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
    leftScore++;
    ballState = RUNNING;
  }
  
  //reflect ball off the VERTICAL ONLY! screen border
  if (ballState == RUNNING) {
    if (ball.getY() < ball.getRadius()/2) {
      ball.reflectBorder();
      ball.moveBall(0, ball.getRadius()/4);
    }
    if (ball.getY() > ySize-ball.getRadius()/2) {
      ball.reflectBorder();
      ball.moveBall(0, -1 * ball.getRadius()/4);
    }
  }
  
  //display/keystroke updates
  ball.display();
  leftPaddle.display();
  rightPaddle.display();
  displayScore();
  if (ballState == RUNNING) {
    if (leftUp && (leftPaddle.getY() > 6)) {leftPaddle.movePaddle(ySize/-90);}
    if (leftDown && (leftPaddle.getY() < (ySize-leftPaddle.getYDimension()-6))) {leftPaddle.movePaddle(ySize/90);}
    if (rightUp && (rightPaddle.getY() > 6)) {rightPaddle.movePaddle(ySize/-90);}
    if (rightDown && (rightPaddle.getY() < (ySize-rightPaddle.getYDimension()-6))) {rightPaddle.movePaddle(ySize/90);}
    ball.moveBallTick();
  }
  
  //debug
  textSize(xSize/80);
  text("Ball X Coordinate: ", 10, 10);
  text((int)ball.getX(), 10, 20);
  
  text("Ball Y Coordinate: ", 10, 40);
  text((int)ball.getY(), 10, 50);
  
  text("Ball Speed: ", 10, 70);
  text((int)ball.getSpeed(), 10, 80);
  
  text("Ball Angle: ", 10, 100);
  text((int)ball.getAngle(), 10, 110);
  
  text("Top Left Paddle Hitbox", 10, 130);
  text((int)topLeftPaddleHitbox, 10, 140);
  
  text("Bottom Left Paddle Hitbox", 10, 160);
  text((int)bottomLeftPaddleHitbox, 10, 170);

  text("Top Right Paddle Hitbox", 10, 190);
  text((int)topRightPaddleHitbox, 10, 200);
  
  text("Bottom Right Paddle Hitbox", 10, 220);
  text((int)bottomRightPaddleHitbox, 10, 230);
  
  text("Paddle Pity", 10, 250);
  text((int)paddlePity, 10, 260);
  
  text("Ball State", 10, 280);
  text(ballState, 10, 290);
}

void keyPressed() {
    //left paddle movement
    if (key == 'w' || key == 'W') {
      leftUp = true;
    }
    if (key == 's' || key == 'S') {
      leftDown = true;
    }
    
    //right paddle movement
    if (keyCode == UP) {
      rightUp = true;
    }
    if (keyCode == DOWN) { 
      rightDown = true;
    }
}

void keyReleased() {
    //left paddle movement
    if ((key == 'w' || key == 'W')) {
      leftUp = false;
    }
    if ((key == 's' || key == 'S')) {
      leftDown = false;
    }
    
    //right paddle movement
    if ((keyCode == UP)) {
      rightUp = false;
    }
    if ((keyCode == DOWN)) {
      rightDown = false;
    }
}

//screen/FPS attributes
static final int FPS = 60;
static final int xSize = /*960;*/1280;
static final int ySize = /*540;*/720;

static final double ballSpeed = xSize/(2.133333*FPS);

//how much distance between paddle and horizontal border?
static final int paddleOffset = xSize/32;

//angle limits for starting ball
static final int rightSideUpperAngle = 388;
static final int rightSideLowerAngle = 332;
static final int leftSideUpperAngle = 208;
static final int leftSideLowerAngle = 152;

//where should the ball check for paddles in xDimension?
static final int rightPaddleEdgeXLocation = xSize - paddleOffset;
static final int leftPaddleEdgeXLocation = paddleOffset;

//what state is the ball in?
static final int RUNNING = 69;
static final int MISSINGLEFT = 70;
static final int MISSINGRIGHT = 71;
static final int RESETTINGLEFT = 72;
static final int RESETTINGRIGHT = 73;
