import processing.pdf.*;
import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.*;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.Gesture.Type;
import com.leapmotion.leap.ScreenTapGesture;
import controlP5.*;


//LEAP
LeapMotionP5 leap;
//GUI
ControlP5 cp5;

ArrayList<Tether> tethers; 
ArrayList<Finger> fingerList;
boolean addTetherState = false; 
Boolean infoState = false;
ColorPicker cpB;
color cBack = color(204);
boolean changeBackground = false;
color c = color(random(255), random(255), random(255));
color cW = color(255, 255, 255, 255); // initial tether colors
color cB = color(0, 0, 0, 255);
//Default colors
//CP5BLUE = new CColor(0xff016c9e, 0xff02344d, 0xff00b4ea, 0xffffffff, 0xffffffff);
Accordion accordion;
Range range;
int saveNum = 1; //for naming the .png outputs
int Transparency = 120; // initial line transparency
int lineWeightMin = 0; // initial lineWeight range
int lineWeightMax = 3;
boolean DrawMode;
boolean New = false;

int WIDTH = 1280;
int HEIGHT = 720;

String name = "Tether v.1.5";

void setup() {
  //Canvas and Title
  size(WIDTH, HEIGHT);
  noStroke();
  smooth();
  fill(150);
  rect(WIDTH - 280, 0, 1280, height);

  //Initialize LEAP
  leap = new LeapMotionP5(this);

  //Initialize tethers
  tethers = new ArrayList<Tether>();

  //Initialize GUI
  cp5 = new ControlP5(this);

  Textlabel titleTextlabel = cp5.addTextlabel("title")
    .setText("TETHER")
      .setPosition(1115, 20)
        .setLineHeight(20)
          ;
  // New tether - press, then screen tap
  cp5.addToggle("New")
    .setPosition(1045, 50)
      .setSize(30, 10)
        .setColorBackground(0xff016c9e)  
          .setColorForeground(0xff00b4ea)
            .setColorActive(color(255, 0, 0))
              ;

  //Draw mode Toggle
  cp5.addToggle("DrawMode")
    .setPosition(1045, 80)
      .setSize(30, 10)
        .setValue(true)
          .setMode(ControlP5.SWITCH)
            ;
  //Save Image
  cp5.addBang("Save")
    .setPosition(1125, 50)
      .setSize(30, 10)
        ;
  //Info
  cp5.addBang("Info")
    .setPosition(1125, 80)
      .setSize(30, 10)
        ;

  //Erase canvas
  cp5.addBang("ClearCanvas")
    .setPosition(1205, 50)
      .setSize(30, 10)
        ;
  // clear tethers
  cp5.addBang("ClearTethers")
    .setPosition(1205, 80)
      .setSize(30, 10)
        ;
  //Background color picker  
  Group backg = cp5.addGroup("Background")
    .setPosition(1000, 180)
      .setWidth(280)
        .setBackgroundHeight(80)
          .setBackgroundColor(color(0, 100))
            ;
  cpB = cp5.addColorPicker("Background Color")
    .setPosition(10, 10)
      .setColorValue(color(204, 204, 204))
        .setGroup(backg)
          ;  

  //Transparency slider
  cp5.addSlider("Transparency")
    .setPosition(1010, 120)
      .setSize(200, 10)
        .setRange(0, 255)
          //.setColorForeground(color(255, 40))
          //.setColorBackground(color(255, 40))
          ;
  //Strokeweight Range
  cp5.addRange("lineWeight")
    .setBroadcast(false)
      .setPosition(1010, 140)
        .setSize(200, 10)
          .setHandleSize(10)
            .setRange(0, 10)
              .setRangeValues(0, 3)
                .setBroadcast(true)
                  ;  


  // Tether menus
  accordion = cp5.addAccordion("acc")
    .setPosition(1000, 260)
      .setWidth(280)
        ;
  // Initial Tethers (2)
  tethers.add(new Tether(new PVector(250, height/2), cB));
  tethers.add(new Tether(new PVector(750, height/2), cW));

  accordion.setCollapseMode(Accordion.MULTI);
  accordion.setItemHeight(80);
  accordion.open();
  //Enable LEAP gesture(s)
  enableGesture();
  background(cpB.getColorValue());
}



void draw() {
  if (changeBackground) {
    background(cBack);
    changeBackground = false;
  }

  if (!DrawMode) {
    background(cBack);
  }

  //Menu field
  fill(150);
  noStroke();
  rect(WIDTH - 280, 0, 1280, height);


  strokeWeight(2);


  fingerList = leap.getFingerList();
  for (Finger finger : fingerList) {
    PVector position = leap.getTip(finger);
    position.y +=100; // shifts to avoid difficulty drawing close to LEAP

    if (position.z < 500 && New == false) {
      for (int i = 0; i < tethers.size(); i++) {
        Tether t = tethers.get(i);
        t.connect(position);
      }
    }
  }

  // Info menu
  hint(DISABLE_DEPTH_TEST);
  cp5.draw();
  if (infoState) {
    fill(255);
    //textSize(15);
    text("CONTROLS :", 1020, 500);
    text("NEW : PRESS THEN SCREEN TAP TO ADD NEW TETHER", 1020, 520);
    text("SAVE : SAVES THE CANVAS AS A PNG", 1020, 560);
    text("DRAWMODE : SWITCHES BETWEEN DRAW AND PAINT MODES", 1020, 540);
    text("CLEARCANVAS : CLEARS THE CANVAS", 1020, 580);
    text("CLEARTETHERS : DELETES ALL TETHERS ", 1020, 600);
    text("TRANSPARENCY : SETS LINE TRANSPARENCY", 1020, 620);
    text("LINEWEIGHT : SETS LINEWIDTH RANGE", 1020, 640);
    text("CREATED BY CASEY BLOOMQUIST / WWW.CASEYBLOOMQUIST.COM", 1020, 700);
  }
  hint(ENABLE_DEPTH_TEST);
}

public void Save() {
  PImage partialSave = get(0, 0, 1000, height);
  partialSave.save("TetherImage_" + saveNum + ".png");
  saveNum++;
}

public void Info() {
  if (infoState) {
    infoState = false;
  } 
  else if (!infoState) {
    infoState = true;
  }
}

public void ClearCanvas() {
  fill(cBack);
  rect(0, 0, 1000, height);
}

public void ClearTethers() {
  for (int i = tethers.size()-1; i>-1; i--) {
    tethers.remove(i);
  }
  accordion.remove();
  accordion = cp5.addAccordion("acc")
    .setPosition(1000, 260)
      .setWidth(280)
        ;
  //accordion.setCollapseMode(Accordion.MULTI);
  //accordion.setItemHeight(80);
}

public void screenTapGestureRecognized(ScreenTapGesture gesture) {
  if (gesture.state() == State.STATE_STOP) {
    if (New ==true && fingerList.size() == 1) {
      PVector pokePos = leap.vectorToPVector(gesture.position());
      if (pokePos.x < WIDTH - 275) {
        color cNew = color(random(255), random(255), random(255));
        tethers.add(new Tether(pokePos, cNew));
        accordion.setItemHeight(80); 
        //accordion.open();
      }
    }
  }
  else if (gesture.state() == State.STATE_START) {
  } 
  else if (gesture.state() == State.STATE_UPDATE) {
  }
}



public void controlEvent(ControlEvent c) {

  // when a value change from a ColorPicker is received, extract the ARGB values
  // from the controller's array value

  if (c.isFrom(cpB)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    cBack = color(r, g, b, a);
    changeBackground = true;
  }
  if (c.isFrom("lineWeight")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    lineWeightMin = int(c.getController().getArrayValue(0));
    lineWeightMax = int(c.getController().getArrayValue(1));
  }
}


void enableGesture() {
  leap.enableGesture(Type.TYPE_SCREEN_TAP);
  //leap.enableGesture(Type.TYPE_SWIPE);
}


public void stop() {
  leap.stop();
}

