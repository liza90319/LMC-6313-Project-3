import arb.soundcipher.*;
import java.util.*;
import de.voidplus.leapmotion.*;



class SoundSensor {
  float pitch;  // Depending on the soundcipher library
  color c;      // Color for the button
  float x, y;   // Where we will put this object on the screen
  float r;      // radius

  SoundSensor(float pitch, color c, float x, float y, float r) {
    this.pitch = pitch;    
    this.c = c;
    this.x = x;
    this.y = y;
    this.r = r;
  }

  SoundSensor(float pitch, color c, float x, float y) {
    this(pitch, c, x, y, 80);
  }

  SoundSensor(SoundSensor s) {
    this(s.pitch, s.c, s.x, s.y, s.r);
  }

  boolean isInside(float x, float y) {
    if(x < this.x)
    //if (dist(x, y, this.x, this.y)<=this.r)
      
      return true;
    else
      return false;
  }

  boolean isMouseInside() {
    return this.isInside(mouseX, mouseY);
  }
}

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
  sc      = new SoundCipher(this);
  sc.instrument = sc.CELLO;

  leap = new LeapMotion(this);

  sensors = new ArrayList<SoundSensor>();
  inside = new ArrayList<Float>();


  sensors.add(new SoundSensor(55, color(255, 0, 0, 200), 40, 40));
  sensors.add(new SoundSensor(60, color(128, 128, 0, 200), 120, 40));
  sensors.add(new SoundSensor(62, color(0, 255, 255, 200), 200, 40));
  sensors.add(new SoundSensor(64, color(255, 0, 255, 200), 200, 120));
  sensors.add(new SoundSensor(65, color(128, 0, 128, 200), 120, 120));
  sensors.add(new SoundSensor(67, color(255, 0, 0, 200), 120, 200));
  sensors.add(new SoundSensor(69, color(255, 255, 0, 200), 120, 280));

  smooth();
  size(displayWidth, displayHeight);
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
  update();
  background(10, 100, 0);
  noStroke();

  for (int i=0; i<sensors.size (); i++) {
    fill(sensors.get(i).c);
    rect(sensors.get(i).x, sensors.get(i).y,width/(sensors.size()),height);
    //ellipse(sensors.get(i).x, sensors.get(i).y, sensors.get(i).r*2, sensors.get(i).r*2);
    fill(255);
    text(str(int(sensors.get(i).pitch)), sensors.get(i).x-10, sensors.get(i).y);
  }

  for ( Hand hand : leap.getHands ()) {
    PVector pos = hand.getPosition();
    int x = (int)((pos.x-300)/1300*displayWidth);
    int y = (int)(((pos.y-700)/300)*displayHeight);

    fill(0);
    ellipse(x,y, 60, 60);
  }
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
