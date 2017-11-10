class NewScrollBar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  int time_since_mouseover;
  int clicked;

  NewScrollBar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    time_since_mouseover = 0;
    clicked = 0;
  }

  void update() {
    if (locked){
      if (!mousePressed){
      locked = false;
      }
      else{
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
      }
    }
    else {
      if (overEvent()) {
        if (!mousePressed){
          time_since_mouseover+=1;
        }
        if (mousePressed){
          if (time_since_mouseover>1){
            locked = true;
          }
        }
      }
      else{
         time_since_mouseover = 0;
      }
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }
 float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  int getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return int(spos * ratio);
  }
}