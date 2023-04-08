public class Ball {

//construction
public Ball(int inputX, int inputY, double inputSpeed, double inputAngle) {
  x = inputX;
  y = inputY;
  speed = inputSpeed;
  angle = inputAngle;
}
  
  
//location
private int x;
private int y;
private int radius = 10;

public int getX() {
    return x;
}

public int getY() {
    return y;
}

//movement
private double speed;
private double angle;

public double getSpeed() {
  return speed;
}

public double getAngle() {
  return angle;
}

//collision
//display

void display() {
  circle(x, y, radius);
}

}
