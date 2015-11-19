import controlP5.*;

/**
 * Kaleidoscope   by Gary George.
 * 
 *Load an image.
 *Move around the mouse to explore other parts of the image.
 *Press the up and down arrows to add slices.
 *Press s to save.
 *
 *I had wanted to do a Kaleidoscope and was inspired with the by Devon Eckstein's Hexagon Stitchery
 *and his use of Mask.  His sketch can be found at http://www.openprocessing.org/visuals/?visualID=1288

 */

int loading=0;
PFont fontA; 
PImage a;
PImage[] loadedImages = new PImage[10];
int totalSlices=8;  // the number of slices the image will start with... should be divisable by 4
int fileCount=0;
int lineCount;
int i;//picture counter
ControlP5 controlP5;
String textValue = "";
Textfield myTextfield;
int previousMouseX, previousMouseY;  //store previous mouse coordinates

void setup() 
{
size(500,500);
background(0,0,0); 
//fontA = loadFont("Verdana-Bold-48.vlw");
smooth();  //helps with gaps inbetween slices
controls();
textFont(fontA, 50);
fill(255);
text(" Enter a Flickr", 50, 150); 
text("  Search Term", 50, 250); 
text("     to Start", 50, 350); 
 }
 
 
public void imageLoader(String term){
   loading =0;
String[] lines;
lines = loadStrings("http://www.PerlitaLabs.com/Kaleidoscope/PicturePull.php?term="+term);
lineCount=lines.length;
 
 
for(i=0;i<lineCount;i++){ 
 text(".", 50+(3*i), 20);
  String[] pieces = split(lines[i], '|');    
  println(pieces[0]);
  println(pieces[1]);
  loadedImages[i]= loadImage(pieces[1]);
  if(loadedImages[i].width > loadedImages[i].height){
  //dont need size the flickr call is for 500s  loadedImages[i].resize(500,0);  //the zero sets makes the height dynamic
  }
  else
  {
   //dont need size the flickr call is for 500s  loadedImages[i].resize(0,500);  //the zero sets makes the width dynamic  
  }
  fileCount++;
 a=loadedImages[int(random(0,lineCount))]; 
 
} 
if(lineCount == 0){
fill(255);
//textFont(fontA, 40);   
background(0,0,0);   
text("No Results", 100, 200);
//textFont(fontA, 12);  
text("Please enter another search", 100, 250); 
}
} 
public void controls(){  
  controlP5 = new ControlP5(this);
  
myTextfield = controlP5.addTextfield("Flickr Search",10,10,120,20);
myTextfield.setFocus(true); 
controlP5.addButton(">>",0,135,10,15,20).setId(1);

   // use setAutoClear(true/false) to clear a textfield or keep text displayed in
  // a textfield after pressing return.
  myTextfield.setAutoClear(true);
  myTextfield.keepFocus(true);
  }

void draw() { 
  if(loading ==2)
  {     
 imageLoader("image1.jpg");///moving to draw() from eventhandler to have loading drawn to the screen
 return;
  }
if(loading ==1){
  fill(255);
textFont(fontA, 50);   
background(0,0,0);   
text("Loading...", 50, 200); 
textFont(fontA, 12);  
text("This may take a minute while the image files are loaded", 30, 250); 
   loading=2;
    return;
}
    
  if(lineCount>0){
 
  if(totalSlices==0)
  { background(0,0,0);  
  image(a,0,0);} else
  {
   if(previousMouseX-mouseX!=0 || previousMouseY-mouseY!=0)
{ 
 background(0,0,0);  
//the width and height parameters for the mask
int w =int(width/3.2); 
int h = int(height/3.2); 
  //create a mask of a slice of the original image.
PGraphics selection_mask; 
selection_mask = createGraphics(w, h, JAVA2D); 
selection_mask.beginDraw(); 
selection_mask.smooth();
selection_mask.arc(0,0, 2*w, 2*h, 0, radians(360/totalSlices+.1));   //using 369 to reduce lines on arc edges
selection_mask.endDraw(); 

float wRatio = float(a.width-w)/float(width);
float hRatio = float(a.height-h)/float(height);
//println("ratio: "+hRatio+"x"+wRatio);
PImage slice = createImage(w, h, RGB); 
slice = a.get(int((mouseX)*wRatio), int((mouseY)*hRatio), w, h);  
slice.mask(selection_mask); 
translate(width/2,height/2); 
float scaleAmt =1.5;
scale(scaleAmt);

for(int k = 0; k<=totalSlices ;k++){ 
  rotate(k*radians(360/(totalSlices/2))); 
  image(slice, 0, 0); 
  scale(-1.0, 1.0);
  image(slice,0,0);
  } 
  }
  resetMatrix();

  }
} 

}
  

 
public void controlEvent(ControlEvent theEvent) {
loading =1;
//println(theEvent.controller().id());
}
 
  
////Key functions change the number of slices and save the image
void keyPressed(){
  switch(keyCode) {
    case RIGHT:
 
    i=(i+1)%lineCount;
  a=loadedImages[i];  
    break;
 
    case LEFT:
    if(i==0){
   i=lineCount-1; 
    }
    else
    {
 i=i-1;
    }
 
 
a=loadedImages[i]; 
    break;
 
    case UP:
      totalSlices=(totalSlices+4)%24;
       if(totalSlices== 16){
    totalSlices=20;}
   
   break;
 
    case DOWN:
  if(totalSlices== 0){
    totalSlices=24;
   
  } else {
    totalSlices=(totalSlices-4)%24;
  }
   if(totalSlices== 16){
    totalSlices=12;
   
  }

      break; 
}
 //saving by pressing "s" 
//if (key=='*'){ 
//String savePath = selectOutput("Name the file.");  // Opens file chooser  
//if (savePath!=null) { 
  //save(savePath +".png"); 
//}// If a destination was chosen, save the current image as a png file where chosen.  
} 
 
//}