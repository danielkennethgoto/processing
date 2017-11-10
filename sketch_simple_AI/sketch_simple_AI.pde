ArrayList agents = new ArrayList(); // list of AI entities
ArrayList foods = new ArrayList(); // list of food pellets for AI entities to gobble
//HScrollbar hs1, hs2;
NewScrollBar sb1, hs1, hs2;
int foodRelease = 0;

void setup() { // this function gets called once and only once, when the program starts
  size(800,960); // this sets the window's size for graphics, in pixels
   hs1 = new NewScrollBar(75, 40, width-600, 10, 16);
   hs1.spos = 30;
   hs2 = new NewScrollBar(75, 55, width-600, 10, 16);
   hs2.spos = 100;
   sb1 = new NewScrollBar(75,70, width-600, 10, 16);
   sb1.spos = 100;
}

void keyReleased() { // when a keyboard key is released, this function is called
  if(key == 'a' || key == 'A') { // A key, whether or not caps lock is on
    agents.add( new Agent(mouseX, mouseY) ); // add Agent. "A" is also for "AIAgent" or "Animal" or "Ant"
  }
  if (key=='c' || key=='C'){
    foods.clear();
  }
  /*if(key == 'f' || key == 'F') { // F key, whether or not caps lock is on
    for(int i=0; i < 25; i++) { // do the following 25 times:
      foods.add( new Food() ); // add Food. "F" is also for "Fruit"
    }
  }
  */
}

void draw() { // this gets called ~30 times per second
  background(0); // erase what we drew for the previous frame
  foodRelease-=1;
  if(foodRelease < 0){
  foodRelease = int( hs1.getPos()-75);
   for(int i=0; i < (hs2.getPos()-75); i++) { // do the following 25 times:
      foods.add( new Food(sb1.getPos()) ); // add Food. "F" is also for "Fruit"
    }
  }
  // uncomment these next two lines to CONSTANTLY add more agents and food (every frame):
  // agents.add( new Agent() );
  // foods.add( new Food() );
  
  for(int i=0; i<foods.size(); i++) { // for each food...
    Food oneFood = (Food)foods.get(i); // get the food at that index
    if (oneFood.drawAndMove()<0){
      foods.remove(oneFood);// draw that food at its position and run any logic for it
    }
  }
  
  // we go through this for loop backwards since we're removing entries while iterating
  // if we removed an entry while iterating forward, we'd skip an entry (!)
  for(int i=agents.size()-1; i>=0; i--) { // for each agent...
    Agent oneAgent = (Agent)agents.get(i); // get the agent at that index
    if(oneAgent.tooHungry()) { // if the agent has gone too long without food
      agents.remove(i); // remove it from the list of agents
    } else { // otherwise
      if (oneAgent.drawAndMove()==1){
        agents.add( new Agent(int(oneAgent.posX), int(oneAgent.posY)) ); 
      }
    }
  }
  
  noStroke(); // turn off outline for the rect call that follows
  fill(0,150); // black box with 100 alpha (out of 255; partial transparency)
  //rect(2,2,290,62); // draw a box under the instructions text to make it more readable
  
  fill(255); // make the following text white
  // on screen instructions:
  text("First click on canvas to put it in focus",5,15);
  text("Press A key to spawn new AI Agent at mouse",5,30);
  text("Food: " + str(int(hs1.getPos()-75)),5,45);
  text("Amount: " + str(int(hs2.getPos()-75)),5,60);
  text("Spoil: " + str(int(sb1.getPos()- 75)),5,75);
  hs1.update();
  hs1.display();
  hs2.update();
  hs2.display();
  sb1.update();
  sb1.display();
}