class DisplayTweet{
  
 //These are the fields/variables of the class 
  float xPos;
  float yPos;
  
  //Color variable
  color tweetColor;
  
  //Text size of the tweet
  float tweetSize;
  
  //Tweet message
  String tweet;

  DisplayTweet(float newXpos, 
                float newYpos, 
                String myTweet, 
                float newTweetSize, 
                color newTweetcolor )
  {
          xPos = newXpos;
          yPos = newYpos;
          tweet = myTweet;
          tweetSize = newTweetSize;
          tweetColor = newTweetcolor;
  }  
  
void drawMe(){
    textSize(tweetSize);
    textAlign(CENTER);
    fill(tweetColor);  
    text(tweets1,xPos,yPos); 
  }
 

 

}

  
