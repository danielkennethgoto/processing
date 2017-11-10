int W= 600;
int H = 600;
int number_of_wheels = 6;
int chassisRadius = 75;
int wheelRadius = 25;
int wheelThickness = 25;
int numberLines = 5;

ArrayList wheels = new ArrayList(); // list of AI entities 
float angle = 0;
int ycenter = H/2;
int xcenter = W/2;
float force;
void setup(){
  size(600,600);
  for (int i=0; i<number_of_wheels;i++){
    wheels.add(new wheel(360/number_of_wheels*i, xcenter,ycenter,chassisRadius,wheelRadius,wheelThickness,numberLines));
  }
}

void keyReleased(){

}

void draw(){
  force = 0;
  background(0);
  angle = 57.2958*atan2((mouseY-ycenter),(mouseX-xcenter));
  for(int i=0; i<wheels.size(); i++) { // for each food...
    wheel newWheel = (wheel)wheels.get(i); // get the food at that index
    force+=newWheel.draw(angle+360/number_of_wheels*i); // draw that food at its position and run any logic for it
  }
  fill(255,255,255);
  stroke(255,255,255);
  ellipse(xcenter,ycenter, 10,10);
  fill(0,255,0);
  stroke(0,255,0);
  triangle(xcenter+force,ycenter-10,xcenter+force,ycenter+10,xcenter+20+force,ycenter);
  rect(xcenter,ycenter-2,force,4);
  delay(10);
}