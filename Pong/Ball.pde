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

public void moveBall() {
  //tick movement, this just updates location every tick/frame
  x += speed*Math.cos(angle);
  y += speed*Math.sin(angle);
}

//collision
//display

void display() {
  circle(x, y, radius);
}

}
