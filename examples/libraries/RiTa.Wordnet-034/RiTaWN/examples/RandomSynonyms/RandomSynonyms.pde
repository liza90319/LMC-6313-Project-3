import rita.wordnet.*;
import java.util.*;

RiWordnet wordnet;
PFont font1, font2;
String word, hypos[];

void setup() 
{
  size(300, 300);    
  font1 = createFont("arial",12);
  font2 = createFont("arial",36);
  wordnet = new RiWordnet(this);
}

void draw() 
{  
  background(40);
  
  // get synonyms every 100 frames 
  if (frameCount%100 == 1)  
  { 
    String[] tmp = null;		
    while (tmp == null) {
      word = wordnet.getRandomWord("n");
      tmp = wordnet.getAllSynonyms(word, "n", 15);
    }    
    Arrays.sort(tmp);
    hypos = tmp;    
  }

  textFont(font2);  // draw query word
  text(word, width-textWidth(word)-30, 40);

  int yPos=60;   // draw the synonyms
  textFont(font1);
  for (int i = 0; i < hypos.length; i++)
    text(hypos[i], 30, yPos += 13);  
}

