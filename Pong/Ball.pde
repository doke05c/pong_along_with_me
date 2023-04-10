public class Ball {

//construction
public Ball(int inputX, int inputY, double inputSpeed, double inputAngle) {
  x = inputX;
  y = inputY;
  speed = inputSpeed;
  angle = inputAngle;
}
  
  
//location
private double x;
private double y;
private int radius = xSize/128;

public double getX() {
    return x;
}

public double getY() {
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
  x += speed*Math.cos(angle*3.1415/180);
  y += speed*Math.sin(angle*3.1415/180);
}

//collision
//display

void display() {
  circle((float)x, (float)y, radius);
}

}
