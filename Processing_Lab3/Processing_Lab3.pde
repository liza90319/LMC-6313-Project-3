import processing.video.*;

// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!


Capture cam;
PImage fragment1;
PImage fragment2;
PImage fragment3;
PImage fragment4;

int currentFilter;

int[] indexes = {0,1,2,3};

//cycle through video filters
int vf1 = 1;
int vf2 = 2;
int vf3 = 3;

int[] xPos;
int[] yPos;

ArrayList<String> bigArray = new ArrayList(); //contains array1 and array 2

int pressSpaceNum;

void setup() {
 // println(Capture.list());
  size(600, 600);
  cam = new Capture(this, 1280,720,15);
  //fragments = new PImage[4];

 //cam_part = get(0,0,100,100);
  cam.start();
  pressSpaceNum = 0;
  
  xPos = new int[10];
    for(int i = 0; i<xPos.length;i++){
      xPos[i] = (int)random(0,width);
    }
  //println("xPos is"+ xPos);
  yPos = new int[5];
     for(int i = 0; i<yPos.length;i++){
      yPos[i] = (int)random(0,width);
    }
 // println("yPos is"+ yPos);
 //add array 2 elements into bigArray
   /*  for (int i = 0; i<array2.length;i++){
        bigArray.add(xPos[i]);
     }*/
  
}

void draw() {
   //getting video
   //making fragment
   //display image
   //set filter based on currentFilter state
  
   //switch (currentFilter)
   

     
  if(cam.available()) {
    cam.read();
  }
  
  image(cam, 0, 0);
  
  fragment1 = get(0,0,300,300);
  fragment2 = get(300,0,300,300);
  fragment3 = get(0,300,300,300);
  fragment4 = get(300,300,300,300);
  
  

  
  
  
  for(int i=0;i<indexes.length;i++){
     
    PImage tempImg = getFragment(indexes[i]); 
     switch(i){
       case 0:
        image(tempImg,0,0);
       case 1:
         image(tempImg,300,0);
       case 2:
         image(tempImg,0,300);
       case 3:
         image(tempImg,300,300);
     } 
  }
  
  
  switch(currentFilter){
     case 0:
       filter(BLUR,6);
       println("blur");
       break;
     case 1:
       filter(THRESHOLD);
       break;
     case 2:
       filter(POSTERIZE, 4);
       break;
     default:
       println("default");
       break;
   }
  
  
  //image(fragment1,;
  //cam_part1 = cam.get(xPos[4],yPos[4],0,0);
  //cam_part2 = cam.get(xPos[4],yPos[4],)
  //for loop to shuffle indexs therefore PImage
  
  //for loop
    //image(fragments[indexes[0]],0,0);
    
 
 /*
  image(cam_part1, 0, 0);
  image(cam_part1, width/2, 0);
  image(cam_part1, width/2, height/2);
  image(cam_part1, 0, height/2);*/

  
  //imageFilter();
  
 
}

/*void imageFilter(){
  if(keyCode == ENTER && pressSpaceNum == 0){
    filter(BLUR,6);
    print("pressSpaceNum is:" + " " + pressSpaceNum);
    pressSpaceNum+=1;
    
  } 
  else if(pressSpaceNum == 1){
    print("pressSpaceNum is:" + " " + pressSpaceNum);
    pressSpaceNum+=1;
  }
  else if(pressSpaceNum == 2){
    print("pressSpaceNum is:" + " " + pressSpaceNum);
    pressSpaceNum = 0;
    }
}*/


void goToNextFilter(){
  currentFilter = currentFilter+1;
    if(currentFilter == 3){
        currentFilter= 0;       
    }
}

void keyPressed(){  
      if(keyCode == ENTER){
       goToNextFilter();
     }
      if(keyCode == UP){
       indexes = ShuffleArray(indexes);
     }
}




int[] ShuffleArray(int[] myArray){
    int N = myArray.length;
    for (int i = 0 ; i < N; i++){
      int randIndex = (int)random(0,N);
      int swap = myArray[randIndex];
      myArray[randIndex] = myArray[i];
      myArray[i] = swap;
    }
    return myArray;
}



PImage getFragment(int fragmentInt){
    if (fragmentInt == 0){
      return fragment1;
    }
    else if(fragmentInt == 1){
      return fragment2;
    }
    else if(fragmentInt == 2){
      return fragment3;
    }
    else if(fragmentInt == 3){
      return fragment4;
    }
    else{
      return fragment1;
    }
}
