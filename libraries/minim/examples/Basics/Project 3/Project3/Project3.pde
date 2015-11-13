import com.leapmotion.leap.processing.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import ddf.minim.signals.*;

import com.leapmotion.leap.*;
import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.processing.*;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.processing.LeapMotion;

//import com.leapmotion.leap.Controller;
//import com.leapmotion.leap.Finger;

//import com.leapmotion.leap.processing.LeapMotion;



LeapMotion      leap;
Minim           minim;
AudioPlayer     track;
AudioRecorder   recorder;
AudioMetaData   meta;
AudioInput      in;
AudioOutput     out;
BeatDetect      beat;
FFT             fft;
FilePlayer      filePlayer;
Gain            gain;
Oscillator      osc;
Oscil           wave;
WaveformRenderer waveform;




//visualization 
int w;
int radius = 200;
float rad = 70;
float volume;
String fileName = "Armin van Buuren - Ping Pong (Original Mix).mp3";
int fingers = 0;
float amp;
float freq;

AudioSample kick;
AudioSample snare;
boolean isFastForward;

//define sound wave colors
float r,g,b;



void setup()
{
  //size(1280, 900);
  size(1280, 800,P3D);
  
  minim = new Minim(this);
  leap = new LeapMotion(this);
  isFastForward = false;
 
  textAlign(CENTER); 
  // this opens the file and puts it in the "play" state.                           
  filePlayer = new FilePlayer( minim.loadFileStream(fileName));
  //filePlayer.loop();
  //volumn 
  gain = new Gain(0.f);
  out = minim.getLineOut();
  wave = new Oscil(20, 4f, Waves.TRIANGLE);
  wave.patch(out);
 
  //osc = new SawWave(100,0.2,out.sampleRate());
  //osc = new SawWave(100,0.2,out.sampleRate());
  //out.addSignal(osc);
  waveform = new WaveformRenderer();
  
  filePlayer.patch(gain).patch(out);
 
  
  recorder = minim.createRecorder(in, "myrecording.wav");
  track = minim.loadFile("Armin van Buuren - Ping Pong (Original Mix).mp3", 1024);
  meta = track.getMetaData();
  beat = new BeatDetect();
  
  kick = minim.loadSample( "BD.mp3",512);
  snare = minim.loadSample("SD.wav",512);
  
  track.loop();
  background(-1);
  
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(),in.sampleRate());
  // create a recorder that will record from the input to the filename specified
  // the file will be located in the sketch's root folder.
  fft.logAverages(60,7);
  w = width/fft.avgSize();
  strokeWeight(w/10);
  strokeCap(SQUARE);
  
 
  
   // use the getLineIn method of the Minim object to get an AudioInput
}

void draw()
{
  //background(0,0,102);
  float t = map(mouseX,0,width,0,1);
  beat.detect(track.mix);
 
  fill(#585858,20);
  noStroke();
  rect(0,0,width,height);
  translate(width/2, height/3+100);
  noFill();
  fill(-1,10);

 

  
  if(beat.isOnset()) rad = rad*0.9;
  else rad = 70;
  ellipse (0,0,2*rad,2*rad);
  stroke(-1,50);
  
  int bsize = track.bufferSize();
  for(int i = 0; i < bsize -1; i+= 5)
  {
    float x = (radius)*cos(i*2*PI/bsize);
    float y = (radius)*sin(i*2*PI/bsize);
    float x2 = (radius + track.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (radius + track.left.get(i)*100)*sin(i*2*PI/bsize);
    line(x, y, x2, y2);
  }
  
  beginShape();
  noFill();
  stroke(-1,50);
  
   for (int i = 0; i < bsize; i+=30)
    {
      float x2 = (radius + track.left.get(i)*100)*cos(i*2*PI/bsize);
      float y2 = (radius + track.left.get(i)*100)*sin(i*2*PI/bsize);
      vertex(x2, y2);
      pushStyle();
      stroke(-1);
      strokeWeight(2);
      point(x2, y2);
      popStyle();
     
      }
      endShape();
     // if (flag)
     // showMeta();
     
  

  fft.forward(in.mix);
  
  
  //draw fft (audio input) on the screen
  for(int i = 0; i < fft.avgSize();i++){
    line((i*w)+(w/2),height,(i*w)+(w/2),height - fft.getAvg(i) * 5);
  }
  
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  for(int i = 0; i < track.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, track.bufferSize(), 0, width );
    float x2 = map( i+1, 0, track.bufferSize(), 0, width );
    line( x1, 50 + track.left.get(i)*50, x2, 50 + track.left.get(i+1)*50 );
    line( x1, 150 + track.right.get(i)*50, x2, 150 + track.right.get(i+1)*50 );
  }
  
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
  }
  
  for (int i = 0; i < kick.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, kick.bufferSize(), 0, width);
    float x2 = map(i+1, 0, kick.bufferSize(), 0, width);
    line(x1, 50 - kick.mix.get(i)*50, x2, 50 - kick.mix.get(i+1)*50);
    line(x1, 150 - snare.mix.get(i)*50, x2, 150 - snare.mix.get(i+1)*50);
  }
  
  for (int i = 0; i <out.bufferSize() - 1; i++)
  {
    line(i, 50 - out.left.get(i)*50, i+1, 50 - out.left.get(i+1)*50);
    line(i, 50 - out.right.get(i)*50, i+1, 50 - out.right.get(i+1)*50);
  }
  
  //draw the waveform in the oscillator
  for(int i =0; i <width-1; i++)
  {
    point(i, height/2 - (height*0.49)*wave.getWaveform().value((float)i/width));
  }
  
  String monitoringState = in.isMonitoring() ? "enabled" : "disableq     d";
  println( "Input monitoring is currently " + monitoringState + ".", 5, 15 );
  
  
 // noStroke();
  fill(153,204,255);
  
  // the value returned by the level method is the RMS (root-mean-square) 
  // value of the current buffer of audio.
  // see: http://en.wikipedia.org/wiki/Root_mean_square
  rect( 0, 0, 50, track.left.level()*width);
  rect( 100, 0, 50, track.right.level()*width);
  

  getVolumeFromHand();
  DisplayNumOfFingers();
}//draw



public void stop() {
 // leap.stop();
}



void showMeta(){
  int time = meta.length();
  textSize(50);
  textAlign(CENTER);
  text((int)(time/1000-millis()/1000)/60 + ":" + (time/1000-millis()/1000)%60, -7, 21);

}

boolean flag = false;


void mousePressed(){
  if (dist(mouseX,mouseY,width/2,height/2)<150) flag = !flag;
}





void DisplayNumOfFingers(){
  textSize(3*height/5.0);
  text(String.valueOf(fingers),width/3,height/5);
  }


void onFrame(final Controller controller){
  fingers = countExtendedFingers(controller);
  
}

void getVolumeFromHand(){
  volume = map(mouseX,0,width,-6,6);
  //track.setVolume(volume);
  textSize(12);
  text("Current Gain is " + volume + " volume.", 10, 20);
}


int countExtendedFingers(final Controller controller)
{
  int fingers = 0;
  if (controller.isConnected())
  {
    Frame frame = controller.frame();
    if (!frame.hands().isEmpty())
    {
      for (Hand hand : frame.hands())
      {
        int extended = 0;
        for (Finger finger : hand.fingers())
        {
          if (finger.isExtended())
          {
            extended++;
          }
        }
        fingers = Math.max(fingers, extended);
      }
    }
  }
  return fingers;
}

void mouseMoved()
  {
    amp = map(mouseY, 0, height, 1, 0);
    wave.setAmplitude(amp);
    
    freq = map(mouseX, 0, width, 110, 880);
    wave.setFrequency(freq);
  }