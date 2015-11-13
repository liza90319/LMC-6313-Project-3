import arb.soundcipher.*;
import java.util.*;
import de.voidplus.leapmotion.*;



boolean arraysAreEqual(ArrayList<Float> a1, ArrayList<Float> a2) {
  HashSet<Float> set1 = new HashSet<Float>(a1);
  HashSet<Float> set2 = new HashSet<Float>(a2);
  return set1.equals(set2);
}

SoundCipher sc;
ArrayList<SoundSensor> sensors;
ArrayList<Float> inside;
LeapMotion leap;


void setup() {
  
   
  size(1280, 900);
  smooth();
  
  sc      = new SoundCipher(this);
  sc.instrument = sc.CELLO;

  leap = new LeapMotion(this);

  sensors = new ArrayList<SoundSensor>();
  inside = new ArrayList<Float>();




}

boolean sketchFullScreen() {
  return true;
}

void mouseClicked() {
  for (int i=0; i<sensors.size (); i++) {
    if (sensors.get(i).isMouseInside()) {
      sensors.add(new SoundSensor(sensors.get(i)));
      break;
    }
  }
}

void mouseDragged() {
  for (int i=0; i<sensors.size (); i++) {
    if (sensors.get(i).isMouseInside()) {
      sensors.get(i).x = mouseX;
      sensors.get(i).y = mouseY;
      break;
    }
  }
}


void mouseMoved() {
  ArrayList<Float> pitchesAL = new ArrayList<Float>();

  for (int i=0; i<sensors.size (); i++) {
    if (sensors.get(i).isMouseInside()) {
      pitchesAL.add(sensors.get(i).pitch);
    }
  }

  if (!arraysAreEqual(inside, pitchesAL)) {
    int n = pitchesAL.size(); 
    float [] pitches = new float[n];
    for (int i=0; i<n; i++) {
      pitches[i] = pitchesAL.get(i);
    }
    sc.playChord(pitches, 80, 2);
    inside = pitchesAL;
  }
}

void draw() {
  frameRate(4);
  
  update();
  background(204, 255, 255);
  noStroke();

  for (int i=0; i<sensors.size (); i++) {
    fill(sensors.get(i).c);
    ellipse(sensors.get(i).x, sensors.get(i).y, sensors.get(i).r*2, sensors.get(i).r*2);
    fill(255);
    text(str(int(sensors.get(i).pitch)), sensors.get(i).x-10, sensors.get(i).y);
  }

  for ( Hand hand : leap.getHands ()) {
    PVector pos = hand.getPosition();
    int x = (int)((pos.x-300)/1300*displayWidth);
    int y = (int)(((pos.y-700)/300)*displayHeight);

    fill(0);
    rect(x,y, 30, 30);
  }
  
  
  sensors.add(new SoundSensor(random(0,10), color(255, 0, 0, 200), 200, 200));
  sensors.add(new SoundSensor(60, color(128, 128, 0, 200), 400, 400));
  sensors.add(new SoundSensor(62, color(0, 255, 255, 200), 500, 500));
  sensors.add(new SoundSensor(64, color(255, 0, 255, 200), 700, 700));
  sensors.add(new SoundSensor(random(40,60), color(128, 0, 128, 200), 800, 800));
  sensors.add(new SoundSensor(67, color(255, 0, 0, 200), 500, 200));
  sensors.add(new SoundSensor(69, color(255, 255, 0, 200), 350, 250));
  sensors.add(new SoundSensor(50,color(40,40,40,200),700,20,50));
  
}


void update() {

  for ( Hand hand : leap.getHands ()) {
    PVector pos = hand.getPosition();
    int x = (int)((pos.x-300)/1300*displayWidth);
    int y = (int)(((pos.y-700)/300)*displayHeight);

    ArrayList<Float> pitchesAL = new ArrayList<Float>();

    for (int i=0; i<sensors.size (); i++) {
      if (sensors.get(i).isInside(x, y)) {
        pitchesAL.add(sensors.get(i).pitch);
      }
    }

    if (!arraysAreEqual(inside, pitchesAL)) {
      int n = pitchesAL.size(); 
      float [] pitches = new float[n];
      for (int i=0; i<n; i++) {
        pitches[i] = pitchesAL.get(i);
      }
      sc.playChord(pitches, 80, 2);
      inside = pitchesAL;
    }
  }
}
