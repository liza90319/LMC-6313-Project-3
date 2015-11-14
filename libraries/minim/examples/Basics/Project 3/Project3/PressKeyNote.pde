
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
    //recorder.save();
    println("Done saving.");
  }
   if ( key == 's' ) snare.trigger();
  if ( key == 'k' ) kick.trigger();
  
  //if(a){fastForward = true;}
  
  
  switch( key ){
    case 'a':
      wave.setAmplitude(2);
      wave.setFrequency(65.4064);
      break;
    
    case 's':
      wave.setAmplitude(2);
      wave.setFrequency(73.4162);
      break;
      
    case 'd':
      wave.setAmplitude(2);
      wave.setFrequency(82.4069);
      break;
      
    case 'f':
      wave.setAmplitude(2);
      wave.setFrequency(87.3071);
      break;
    
    case 'g':
      wave.setAmplitude(2);
      wave.setFrequency(97.9989);
      break;
    
    case 'h':
      wave.setAmplitude(2);
      wave.setFrequency(110.000);
      break;
    case 'j':
      wave.setAmplitude(2);
      wave.setFrequency(123.471);
      break;
  
  
  }//switch
  
  
  
  
  
}