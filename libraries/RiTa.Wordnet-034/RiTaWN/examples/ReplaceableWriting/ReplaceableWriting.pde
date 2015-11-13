import rita.*; // also requires the core RiTa library
import rita.wordnet.*;

RiText[] rts; 
RiWordnet wordnet; 

String text = "Last Wednesday we decided to visit the zoo. We arrived the next morning after we breakfasted, cashed in our passes and entered. We walked toward the first exhibits. I looked up at a giraffe as it stared back at me. I stepped nervously to the next area. One of the lions gazed at me as he lazed in the shade while the others napped. One of my friends first knocked then banged on the tempered glass in front of the monkey's cage. They howled and screamed at us as we hurried to another exhibit where we stopped and gawked at plumed birds. After we rested, we headed for the petting zoo where we petted wooly sheep who only glanced at us but the goats butted each other and nipped our clothes when we ventured too near their closed pen. Later, our tired group nudged their way through the crowded paths and exited the turnstiled gate. Our car bumped, jerked and swayed as we dozed during the relaxed ride home.";

void setup()
{
  size(480, 480);
  wordnet = new RiWordnet(this);
  RiText.defaultFont("Times", 18);
  rts = RiText.createLines(this, text, 30, 50, 420);
}

void draw()
{
  background(255);

  // substitute every 120 frames 
  if (frameCount % 30 == 1)   
    doSubstitution();
    
  RiText.drawAll();
}

/*  replace a random word in the paragraph with one
 from wordnet with the same (basic) part-of-speech */
void doSubstitution()
{
  String[] words = RiTa.tokenize(text);

  // loop from a random spot
  int count =  (int)random(0, words.length);
  for (int i = count; i < words.length; i++) 
  {
    // only words of 3 or more chars
    if (words[i].length()<3) continue;

    // get the pos
    String pos = wordnet.getBestPos(words[i].toLowerCase());        
    if (pos != null) 
    {
      // get the synset
      String[] syns = wordnet.getSynset(words[i], pos);
      if (syns == null) continue;

      // pick a random synonym
      String newStr = syns[(int)random(0, syns.length)];

      // preserve capitalization
      if (Character.isUpperCase(words[i].charAt(0)))
        newStr = RiTa.upperCaseFirst(newStr);

      // and make the substitution
      text = text.replaceAll("\\b"+words[i]+"\\b", newStr);
      
      RiText.disposeAll();   // clean up the last batch

      // create a RiText[] from 'test' starting at (30,50) & going down
      rts = RiText.createLines(this, text, 30, 50, 420);    
      
      break;
    }

    if (count == words.length) count = 0; // back to beginning
  }
}
