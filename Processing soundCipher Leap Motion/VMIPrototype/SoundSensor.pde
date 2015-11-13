

class SoundSensor {
  float pitch;  // Depending on the soundcipher library
  color c;      // Color for the button
  float x, y;   // Where we will put this object on the screen
  float r;      // radius

  SoundSensor(float pitch, color c, float x, float y, float r) {
    this.pitch = pitch;    
    this.c = c; //color
    this.x = x; //x position
    this.y = y; //y position
    this.r = r; //radius
  }

  SoundSensor(float pitch, color c, float x, float y) {
    this(pitch, c, x, y, 80);
  }

  SoundSensor(SoundSensor s) {
    this(s.pitch, s.c, s.x, s.y, s.r);
  }

  boolean isInside(float x, float y) {
    if (dist(x, y, this.x, this.y)<=this.r)
      return true;
    else
      return false;
  }

  boolean isMouseInside() {
    return this.isInside(mouseX, mouseY);
  }
}//end class
