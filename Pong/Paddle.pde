public class Paddle {

//construction
public Paddle(double inputX, double inputY, double inputXDimension, double inputYDimension) {
  x = inputX;
  y = inputY;
  xDimension = inputXDimension;
  yDimension = inputYDimension;
}

//location
private double x;
private double y;
private double xDimension;
private double yDimension;

public double getX() {
  return x;
}

public double getY() {
  return y;
}

public double getXDimension() {
  return xDimension;
}

public double getYDimension() {
  return yDimension;
}

//movement
public void movePaddle(double amount) {
  //userinput movement, this updates location every keystroke
  y += amount;
}

//collision
//display

public void display() {
  rect((float)x, (float)y, (float)xDimension, (float)yDimension);
}
  
}
