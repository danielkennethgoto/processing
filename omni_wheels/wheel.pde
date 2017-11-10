class wheel {
  float posX, posY;
  float speed;
  int chassisRadius;
  int wheelRadius;
  int wheelThickness;
  float deltaAngle;
  float state;
  FloatList lines;
  int numberLines;
  float force;
  
  wheel(float Angle, int x, int y, int a, int b, int c, int d) {
    posX = x;
    posY = y;
    chassisRadius = a;
    wheelRadius = b;
    wheelThickness = c;
    numberLines = d;
    state = wheelRadius;
    deltaAngle = Angle;
    lines = new FloatList();
    for (int i=0;i<numberLines;i++){
      lines.append(2*wheelRadius/numberLines*i-wheelRadius);
    }
  }
    
float draw(float angle){
    speed = sin(angle*0.0174533);
    state+=speed;
    force = speed*30;
    force = abs(force);
    noStroke();
    fill(0,255,0);
    stroke(0,255,0);
    triangle(cos((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posX+force+5, sin((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posY,cos((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posX+force, sin((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posY+4,cos((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posX+force, sin((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posY-4);
    rect(cos((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posX, sin((angle)*0.0174533)*(chassisRadius+wheelThickness/2)+posY-1,force,2);
    fill(255,255,0);
    stroke(255,255,0);
    fill(255,255,255);
    stroke(255,255,255);
    line(-cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*chassisRadius+posX,sin((angle)*0.0174533)*chassisRadius+sin((90-angle)*0.0174533)*wheelRadius+posY,cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*chassisRadius+posX,sin((angle)*0.0174533)*chassisRadius-sin((90-angle)*0.0174533)*wheelRadius+posY);
    line(-cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*(chassisRadius+wheelThickness)+posX,sin((angle)*0.0174533)*(chassisRadius+wheelThickness)+sin((90-angle)*0.0174533)*wheelRadius+posY,cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*(chassisRadius+wheelThickness)+posX,sin((angle)*0.0174533)*(chassisRadius+wheelThickness)-sin((90-angle)*0.0174533)*wheelRadius+posY);
    line(-cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*chassisRadius+posX,sin((angle)*0.0174533)*chassisRadius+sin((90-angle)*0.0174533)*wheelRadius+posY,-cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*(chassisRadius+wheelThickness)+posX,sin((angle)*0.0174533)*(chassisRadius+wheelThickness)+sin((90-angle)*0.0174533)*wheelRadius+posY);
    line(cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*chassisRadius+posX,sin((angle)*0.0174533)*chassisRadius-sin((90-angle)*0.0174533)*wheelRadius+posY,cos((90-angle)*0.0174533)*wheelRadius+cos((angle)*0.0174533)*(chassisRadius+wheelThickness)+posX,sin((angle)*0.0174533)*(chassisRadius+wheelThickness)-sin((90-angle)*0.0174533)*wheelRadius+posY);
    stroke(0,255,255);
    for (int i=0;i<numberLines;i++){
      state = (float)lines.get(i)+speed;
      if (speed>0){
        if (state>wheelRadius){
          state=0-wheelRadius;
        }
      }
      else if (speed<0){
        if (state<(0-wheelRadius)){
          state=wheelRadius;
        }
      }
      line(-cos((90-angle)*0.0174533)*state+cos((angle)*0.0174533)*chassisRadius+posX,sin((angle)*0.0174533)*chassisRadius+sin((90-angle)*0.0174533)*state+posY,-cos((90-angle)*0.0174533)*state+cos((angle)*0.0174533)*(chassisRadius+wheelThickness)+posX,sin((angle)*0.0174533)*(chassisRadius+wheelThickness)+sin((90-angle)*0.0174533)*state+posY);
      lines.set(i,(float)(state));
    }
  return (float)force;
  }
}