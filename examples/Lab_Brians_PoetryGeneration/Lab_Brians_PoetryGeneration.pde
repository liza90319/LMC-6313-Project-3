/* Poetry generator

This program randomly generates poems comprised of nouns, verbs, adverbs, and adjectives based on 
given word lists for each kind of word.  To run this, the paths of the word lists must be updated
to be the correct path on your computer for where the word files are.  The files I used were grabbed from
http://www.ashley-bovan.co.uk/words/partsofspeech.html

*/

//Import this library if you want to use ArrayLists or Lists.
import java.util.*;


// create the arrays to hold our word lists
List<String> adjectives, nouns, verbs, adverbs;
 
void setup() {


adjectives= Arrays.asList(loadStrings("data/1syllableadjectives.txt"));
nouns= Arrays.asList(loadStrings("data/nounlist.txt"));
verbs= Arrays.asList(loadStrings("data/2syllableverbs.txt"));
adverbs= Arrays.asList(loadStrings("data/6Kadverbs.txt"));


}


// returns however we define a sentence to be
String getSentence(){
 return new String(getNounPhrase() + " " + getVerb());
}

// returns a noun or an adjective plus the result of a recursive call
String getNounPhrase(){
   int coinFlip = int(random(0,3));
   if(coinFlip==0) return getNoun();
   else return new String(getAdjective() + " " + getNounPhrase());
}

// returns a random noun
String getNoun(){
  //println("getting a noun!");
  return getRandomWord(nouns); 
}

// returns a random verb
String getVerb(){
  //println("getting a verb!");
  return getRandomWord(verbs); 
}

// returns a random adjective
String getAdjective(){
  //println("getting an adjective!");
  return getRandomWord(adjectives); 
}

// returns a random adverb
String getAdverb(){
  //println("getting an adverb!");
  return getRandomWord(adverbs); 
}

// returns a random word from a specified array of Strings
String getRandomWord(List wordList){
    //println("Size is"+wordList.size());
    int index = int(random(wordList.size()));
    //println("getting random word: " + (String) wordList.get(index));
    return (String) wordList.get(index);
}  

void draw(){
  // the below is personal preference for creating a poem out of the word lists I used
  println(new String(getSentence()));
  println(new String(getAdverb()));  
  println(new String(getAdverb()));
  println(new String(getSentence()));
  println(new String(getAdverb()));
  println(new String(getAdverb()));
  println(new String(getNoun()));
  noLoop();
}
