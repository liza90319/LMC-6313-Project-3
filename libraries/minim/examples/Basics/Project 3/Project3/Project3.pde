import com.leapmotion.leap.processing.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;



/**
  * This sketch demonstrates how to use the AudioBuffer objects of an AudioPlayer 
  * to draw the waveform and level of the sound as it is playing. These same 
  * AudioBuffer objects are available on AudioInput, AudioOuput, and AudioSample,
  * so they same drawing code will work in those cases.
  *
  */

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


Minim           minim;
AudioPlayer     track;
FilePlayer      filePlayer;
AudioMetaData   meta;
BeatDetect      beat;
AudioInput      in;
AudioOutput     out;
Gain            gain;
AudioRecorder   recorder;
FFT             fft; //fft splits up a sound wave intp a selection of bands, 
        //like spectrum, allowing you to what the volume of different frequencies of the sound signal

LeapMotion leap;



//visualization 
int w;
int radius = 200;
float rad = 70;
float volume;
String fileName = "Armin van Buuren - Ping Pong (Original Mix).mp3";
int fingers = 0;

AudioSample kick;
AudioSample snare;
boolean isFastForward;

//define sound wave colors
float r,g,b;



void setup()
{
  size(1280, 900);
  //size(1280, 800,P3D);
  
  minim = new Minim(this);
  leap = new LeapMotion(this);
  isFastForward = false;
  
  
 
  
  
  //display # of fingers on the screen
  
  textAlign(CENTER);
  
  // this opens the file and puts it in the "play" state.                           
  filePlayer = new FilePlayer( minim.loadFileStream(fileName) );
  //volumn
  gain = new Gain(0.f);
  out = minim.getLineOut();
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
  
  //fill(#9900CC,20);
 // rect(width/4,0,width/4,height);
  
  //fill(#FFFF66,20);
  //rect(width/2,0,width/4,height);
  
  //fill(#99CCFF,20);
  //rect((width/4)*3,0,width/4,height);
 
    
  DisplayNumOfFingers();

  
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

void keyPressed()
{
  if ( key == 'm' || key == 'M' )
  {
    if ( in.isMonitoring() )
    {
      in.disableMonitoring();
    }
    else
    {
      in.enableMonitoring();
    }
  }
  
   if ( key == 'r' ) 
  {
    // to indicate that you want to start or stop capturing audio data, you must call
    // beginRecord() and endRecord() on the AudioRecorder object. You can start and stop
    // as many times as you like, the audio data will be appended to the end of the buffer 
    // (in the case of buffered recording) or to the end of the file (in the case of streamed recording). 
    if ( recorder.isRecording() ) 
    {
      recorder.endRecord();
    }
    else 
    {
      recorder.beginRecord();
    }
  }
  if ( key == 's' )
  {
    // we've filled the file out buffer, 
    // now write it to the file we specified in createRecorder
    // in the case of buffered recording, if the buffer is large, 
    // this will appear to freeze the sketch for sometime
    // in the case of streamed recording, 
    // it will not freeze as the data is already in the file and all that is being done
    // is closing the file.
    // the method returns the recorded audio as an AudioRecording, 
    // see the example  AudioRecorder >> RecordAndPlayback for more about that
    recorder.save();
    println("Done saving.");
  }
   if ( key == 's' ) snare.trigger();
  if ( key == 'k' ) kick.trigger();
  
  //if(a){fastForward = true;}
  
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
  //gain.setValue(volume);
  track.setVolume(volume);
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