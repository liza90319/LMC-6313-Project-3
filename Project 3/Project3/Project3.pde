//Minim Library



//Processing-Leap Motion library
import de.voidplus.leapmotion.*;

//SoundCipher library
import arb.soundcipher.*;


LeapMotion leap;
//Minim minim;
//AudioOutput out;

SoundCipher sc = new SoundCipher(this);
SoundCipher sc2 = new SoundCipher(this);
SoundCipher sc3 = new SoundCipher(this);


int x, y, deg; 
int mode = 1;
int nbr =60;
Dot[] d = new Dot[nbr];

float maxRadius  = 200; 
float angle=0;

float[] pitchSet = {57, 60, 60, 60, 62, 64, 67, 67, 69, 72, 72, 72, 74, 76, 79};
float setSize = pitchSet.length;
float keyRoot = 0;
float density = 0.8;



//InteractionBox Attributes Defined Here

//PVector boxCenter = interactionBox.center();


void setup(){
  size(800,600);
  background(233, 233, 220);
  leap = new LeapMotion(this);
  frameRate(8);
  smooth();
  sc3.instrument(49);
  x = width/2;
  y = height/2;
  float deg = (360/nbr);
    for(int i=0;i<d.length;i++){
      angle += radians(deg);
      maxRadius += random(100);
        d[i]= new Dot(x + cos(angle)*maxRadius, y+sin(angle)*maxRadius,random(-20,20),i);
    }

}

void draw(){
    //background(233,233,220);
  if(random(1) < density){
    sc.playNote(pitchSet[(int)random(setSize)] + keyRoot, random(90)+30,random(20)/10 +0.2);
    fill(color(random(256), random (256), random(256)));
    rect(random(100),random(100),random(40),random(40));
  }
  
  if(frameCount%32 == 0) //execute every 32 frames
  {    
    keyRoot = (random(4)-2)*2;
    density = random(7) / 10 + 0.3;
    sc2.playNote(36+keyRoot,random(40) + 70, 8.0);
  } 
  
  if(frameCount%16 == 0){
   float[] pitches = {pitchSet[(int)random(setSize)]+keyRoot-12, pitchSet[(int)random(setSize)]+keyRoot-12};
    sc3.playChord(pitches, random(50)+30, 4.0);
  }
  
  
  for( Hand hand : leap.getHands()){
    hand.draw();
    for (Finger finger : hand.getFingers()){
      finger.draw();
    }
  }
  
  beginShape();
     for (int i=0; i<d.length; i++){
       d[i].maison();
       stroke(20);
       noFill();
     vertex(d[i].x , d[i].y);
     }
  endShape(CLOSE);
 
  
}

void mouseReleased (){
  //background(233,233,220);
  float deg = (360/nbr);
  for (int i=0;i<d.length;i++){
    angle += radians(deg);
    maxRadius = 200+random(20);
    d[i] = new Dot(x + cos(angle)*maxRadius  , y+ sin(angle)*maxRadius, random(-20, 20), i);
  }
}

 
class Dot{
  float x, y;
  float vx, vy;
  float ar = random(-20, 20);
  int id;
  Dot(float xpos, float ypos, float angledeRotation, int moi){
    x  = xpos;
    y  = ypos;
    ar  = angledeRotation;
    id = moi ;
  }
  void maison(){
     ar+=random(0.2);
     x += cos(ar)*(random(1))+((width/2 - x) * 0.025); 
     y += sin(ar)*(random(1))+((height/2 - y) * 0.025); 
  }
}