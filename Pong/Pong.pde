//score variables
public int leftScore = 0;
public int rightScore = 0;

//booleans for paddle movement check
public boolean leftUp = false;
public boolean leftDown = false;
public boolean rightUp = false; 
public boolean rightDown = false; 

//display score on screen
public void displayScore() {
  textSize(xSize/20);
  text(leftScore, xSize/2 - xSize/16, ySize/10); 
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
Paddle leftPaddle = new Paddle(paddleOffset-(xSize/80), ySize/2, xSize/80, ySize/10);
Paddle rightPaddle = new Paddle(xSize-paddleOffset, ySize/2, xSize/80, ySize/10);


//every tick
void draw(){
  background(0);
  
  //where is each end of the paddle yDimension hitbox?
  double topLeftPaddleHitbox = leftPaddle.getY()-ball.getRadius()/2-paddlePity;
  double bottomLeftPaddleHitbox = leftPaddle.getY()+leftPaddle.getYDimension()+ball.getRadius()/2+paddlePity;
  double topRightPaddleHitbox = rightPaddle.getY()-ball.getRadius()/2-paddlePity;
  double bottomRightPaddleHitbox = rightPaddle.getY()+rightPaddle.getYDimension()+ball.getRadius()/2+paddlePity;
  
  //determination of points: if ball hits a paddle, reflect. if ball misses paddle, increase score of other side
  if (ball.getX() < leftPaddleEdgeXLocation+ball.getRadius()/2) {
    if ((ball.getY() < topLeftPaddleHitbox) || (ball.getY() > bottomLeftPaddleHitbox)) {
      ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
      rightScore++;
    } else {
      ball.reflectPaddle(getPaddleAngle(ball, topLeftPaddleHitbox, bottomLeftPaddleHitbox)); //figure out a way to change angle relative to ball pos on paddle
    }

  } else if (ball.getX() > rightPaddleEdgeXLocation-ball.getRadius()/2) {
    if ((ball.getY() < topRightPaddleHitbox) || (ball.getY() > bottomRightPaddleHitbox)) {
      ball = new Ball(xSize/2, ySize/2, ballSpeed, determineAngle());
      leftScore++;
    } else {
      ball.reflectPaddle(180-getPaddleAngle(ball, topRightPaddleHitbox, bottomRightPaddleHitbox)); //figure out a way to change angle relative to ball pos on paddle
    }
  }
  
  //reflect ball off the VERTICAL ONLY! screen border
  if (ball.getY() < ball.getRadius()/2) {
    ball.reflectBorder();
    ball.moveBall(0, ball.getRadius()/4);
  }
  if (ball.getY() > ySize-ball.getRadius()/2) {
    ball.reflectBorder();
    ball.moveBall(0, -1 * ball.getRadius()/4);
  }
  
  //display/keystroke updates
  if (leftUp && (leftPaddle.getY() > 6)) {leftPaddle.movePaddle(ySize/-90);}
  if (leftDown && (leftPaddle.getY() < (ySize-leftPaddle.getYDimension()-6))) {leftPaddle.movePaddle(ySize/90);}
  if (rightUp && (rightPaddle.getY() > 6)) {rightPaddle.movePaddle(ySize/-90);}
  if (rightDown && (rightPaddle.getY() < (ySize-rightPaddle.getYDimension()-6))) {rightPaddle.movePaddle(ySize/90);}
  ball.display();
  leftPaddle.display();
  rightPaddle.display();
  displayScore();
  ball.moveBallTick();
  
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

//how much leeway can we give the player for paddle reflects in yDimension?
static final int paddlePity = 3; //update to increase the closer the angle is to vertical (90 or 270)
