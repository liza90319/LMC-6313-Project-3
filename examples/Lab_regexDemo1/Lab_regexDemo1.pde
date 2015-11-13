/*

*Do not* download RiTa from Processing's library manager!

Download this older, less complete library: http://rednoise.org/rita-archive/RiTa.Wordnet-034.zip

Put the enclosed 'RiTaWN' folder into the 'libraries' folder, the same way you did with Twitter4J.

You can find the documentation for Rita.Wordnet in the 'reference' folder of 'RiTaWN'.

Note: if you install complete, updated (but as of this writing, broken for Java) RiTa down the line,
you'll need to delete your RiTaWN folder, as it creates a conflict.

*/

import rita.wordnet.*;

void setup() {
  String example = "This is an example!";
  println("1_____");
  println(example.contains("is"));
 
  println("2_____");
  println(example.matches("is"));
  //"is" is within "This is an example!" but it has characters surrounding it
  //these characters need to be accounted for in a regular expression
  
  println("3_____");
  println(example.matches(".is.")); //. means any character
  //. is any character but this is looking for a 4-character string, exactly
  
  
  println("4_____");
  println(example.matches(".*is.*"));
  //* means "the previous character zero or more times", so here it means "any character any amount of times"
  //(it leaves things pretty open-ended)
  
  //so what can we do with these concepts?
  //first, let's cut up our string
  String[] splitExample = example.split(" ");
  //the split() method of a function divides the string into an array of strings
  //cutting along the string you give it (space, in this case).
  
  println("-*-*-*-*-\n");
  //note that \n adds a new line
  //remember that \ can sometimes 'escape' what follows it so it's treated differently
  println("5__STRING SPLIT EXAMPLE.");
  for (int i = 0; i < splitExample.length; i++) {
    //let's loop through the split-up string's elements and print them individually
    println(splitExample[i]);
  }
  //it's broken into individual words! Note that punctuation comes along.
  

  println("6__RITA-WORDNET EXAMPLE");

  //instantiating the RiTa.Wordnet object here
  RiWordnet rwn = new RiWordnet();
  String reconstructedString = "";
  for (int i = 0; i < splitExample.length; i++) {
    if (splitExample[i].matches(".*is.*")) {
      String pos = rwn.getBestPos(splitExample[i]); //need to have a part of speech for wordnet regex search
      println("");
      if (pos == null) { //What if the word doesn't come back as "n", "v", "a", or "r"?
        pos = "v"; //we'll just make it a verb. not sure why we can't check all
      }
      String[] regexMatches = rwn.getRegexMatch(".*is.*", pos); //get any and all regex matches for the part of speech.
      if (regexMatches.length > 0) { // just to be safe
        String randomMatch = regexMatches[int(random(regexMatches.length))]; //grab random random regex match
        reconstructedString += randomMatch+" "; //put random regex match in new string
      } else {
        reconstructedString += splitExample[i]+" "; //add regular word back into new string
      } // end if-else for safe word replacement on match
    } else {
      reconstructedString += splitExample[i]+" "; //add regular word back into new string
    } // end if-else for regex match
  }// end loop through words
  println("6____");
  println(example); //print original
  println(reconstructedString); //print new weird thing!
  /*
  Finally, just generating a sentence based on regex matches
  This is going to be:
  "Please do not <adverb starting with "r" and ending in "ly"> <verb beginning with r, with "e" in it, and ending in "ate"> <adjective beginning with r and ending in "ish"> <noun beginning with r, ending in "es">."
  */
  String[] advStrs = rwn.getRegexMatch("r.*ly", "r");
  String[] vStrs = rwn.getRegexMatch("r.*e.*ate", "v");
  String[] adjStrs = rwn.getRegexMatch("r.*ish", "a");
  String[] nStrs = rwn.getRegexMatch("r.*es", "n");
  //now, randomly select one of the results
  String adv = advStrs[int(random(advStrs.length))];
  String v = vStrs[int(random(vStrs.length))];
  String adj = adjStrs[int(random(adjStrs.length))];
  String n = nStrs[int(random(nStrs.length))];
  String sillyString = "Please do not "+adv+" "+v+" "+adj+" "+n+".";
  println("7____\n"+sillyString);
  /*
  ...there's a lot more you can do with these functions...!
  
  you don't need to use wordnet to work with this concept, either.
  
  you could loop through all of the words in a .txt file to find regex matches
  ^(using the matches() method of String objects)^
  
  unfortunately, you can't use regexes for twitter searches.
  
  further resources for regex(regular expressions) info, in order of complexity:
  http://docs.oracle.com/javase/7/docs/api/java/lang/String.html <-- quick reminder of the String documentation
  http://www.zytrax.com/tech/web/regex.htm <--an introduction to regular expressions.
  http://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html
  ^you don't actually need the Pattern class to make regexes(regular expressions), but this page documents them in java
  
  */
}
