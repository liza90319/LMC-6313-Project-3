//import twitter4j.Status;

class DisplayTweet {
  
    //Class variables:
      //Tweet coordinates
      float xPos;
      float yPos;

      //Color variable
      color tweetColor;
  
      //Text Size of the tweet.
      float tweetSize;
      
      //tweet message.
      String tweet; 
      
      //Albith: The Status object, that contains all the tweet information,
      //can also be a class variable.  Consider using this if your project 
      //requires more information from each tweet.      
          //Status myTweetStatus;

      //Constructor for the DisplayTweet() class.  
      DisplayTweet(float newXPosition, 
                   float newYPosition, 
                   String myTweet, 
                   float mySize, 
                   color newColor)
       {
        
              xPos= newXPosition;
              yPos= newYPosition;
              tweet= myTweet;
              tweetSize= mySize;
              tweetColor= newColor;
        }

      //Draw method that displays the tweet.
      void drawMe()
      {
        
        textSize(tweetSize);
        textAlign(CENTER);
        fill(tweetColor);
        text(tweet, xPos, yPos );
           
      }
      
}
