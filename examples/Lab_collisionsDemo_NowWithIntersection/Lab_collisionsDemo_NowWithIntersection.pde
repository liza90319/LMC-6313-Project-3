//import the java Rectangle class... does not work in JavaScript mode.
import java.awt.Rectangle;

//create an array of Rectangle objects
Rectangle[] boxes = new Rectangle[6];

int BOX_SIZE = 30;

void setup() {
  size(400,400);
  for (int i = 0; i < boxes.length; i++) {
    //instantiate Rectangle objects
    boxes[i] = new Rectangle(int(random(width)), int(random(height)), BOX_SIZE, BOX_SIZE);
    //rectangle objects are constructed with x, y, width, height as arguments
  }
  //hide the cursor
  noCursor();
}

void draw() {
  background(255);
  //make one box follow the mouse
  boxes[0].setLocation(mouseX,mouseY);
  //loop through all boxes
  for (int i = 0; i < boxes.length; i++) {
    //use styles to work with these independently
    pushStyle();
    //make stroke color black
    stroke(0,0,0);
    //assume no collision, set fill to green
    fill(0,255,0);
    //see if the box is colliding with any other box, loop through them
    for (int j = 0; j < boxes.length; j++) {
      //don't check to see if it's intersecting itself... (if j != i)
      if (j != i && boxes[i].intersects(boxes[j])) { //check to see if intersects() returns true
        //figure out and draw intersection, with cyan fill
        Rectangle tempRect = boxes[i].intersection(boxes[j]); //intersection() returns a Rectangle, let's hold on to it
        fill(0,255,255);
        rect(tempRect.x, tempRect.y, tempRect.width, tempRect.height);
        
        //if we have an intersection, have no fill for the primary (i) rectangle
        noFill();
      }
    }
        
    //now draw the box we're on
    
    rect(boxes[i].x, boxes[i].y, boxes[i].width, boxes[i].height);
    //x, y, width, and height are all properties of any Rectangle object
    popStyle();
  }
   /*
  keep in mind that, the way this is written, the collisions are checked
  "in both directions", meaning boxes[2] checks boxes[3] for collision
  AND boxes[3] checks boxes[2]. make sure you don't accidentally do
  something twice when you only mean it to happen once. right now, we're just
  changing the fill for the box doing the checking, so there's no harm done.
  however, if you had a collisionCounter variable, you wouldn't want to write
  "collisionCounter++" where "fill(255,0,0)" is. it would increment too often,
  unless you did want to count one collision between two rectangles as two
  collisions for some reason.
  */
}
