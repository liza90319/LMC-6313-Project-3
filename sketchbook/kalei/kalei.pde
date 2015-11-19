PImage img; // Declare variable “a” of type PImage
PImage img1;
PImage img2;
PImage img3;

void setup() {
size(700, 500);
img = loadImage("img1.jpg");  // Load the image into the program
img1 = loadImage("img2.jpg");
img2 = loadImage("img3.jpg");
}

void draw() {
background(0);

int x = 0;  // this is where the loop starts
// int y = 200;
int w = mouseX/10;  // this is the width of each “slice”
while (x < width) {

translate(width/2, height/2);
rotate(10);
copy(img1, x, 0, w, 400, x, 0, w, 400);
copy(img, x+w, 0, w, 400, x+w, 0, w, 400);
copy(img2, x+w, 0, w, 640, x+w, 0, w, 640);

x = x + 7; // this is how far apart each “slice” is

}
}