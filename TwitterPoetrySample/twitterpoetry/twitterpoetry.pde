import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
 
Twitter twitter;
String searchString = "#breastcancerawareness";
List<Status> tweets;
 
int currentTweet;
int yPos= 0 ;
int xPos= 0 ;

int[] starX = new int[100];
int[] starY = new int[100];

String urlPattern = "https?://.*( |$)"; //should find all URLs (unless someone posts a URL starting in ftp:// or some other, far less common protocol)
String handlePattern = "@([A-Za-z0-9_]{1,15})"; //looks for A-Z, a-z, 0-9, or _ in any combination between 1 and 15 characters long, following an @
String hashtagPattern = "#.*( |$)"; //looks for any characters following a # sign, and ending in a space or the end of the tweet

String modifiedTweet = "";
void setup()
{
  size(1000, 800);
 
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("SSLkyRqHSnQr7i88dp1oDk5FN");
  cb.setOAuthConsumerSecret("Woa1Yjx116bb6Qwdn20wmhpmdHpmxcBwD60bKlq7QMVDIsL93n");
  cb.setOAuthAccessToken("480462489-u1LZwX7mCdEpDgIHnFHg7XwA5CndcpZSrPqhzN7F");
  cb.setOAuthAccessTokenSecret("X63iEo292Soc3ZDFvD701zlWqzLoyHdqRwMzInZhbg7kS");
 
  TwitterFactory tf = new TwitterFactory(cb.build());
 
  twitter = tf.getInstance();
 
  getNewTweets();
 
  currentTweet = 0;
 
  thread("refreshTweets");
   
   fill(0);
  rect(0, 0, width, height);
 
}
 
void draw()
{
 
  fill(0, 50);
  rect(0, 0, width, height);
 
  currentTweet = currentTweet + 1;
 
  if (currentTweet >= tweets.size())
    {currentTweet = 0;}
 
  Status status = tweets.get(currentTweet);
  textSize(20) ;
  fill( int(random(255)), int(random(100)), int(random(100)));
  
  
  text(status.getText()+ status.getCreatedAt(), xPos, yPos, 300, 100);
 
  yPos= yPos + 70 ;
 
  if (yPos >= height) {
    yPos = 0; 
    xPos= xPos + 50 ;
  }
   
  if (xPos >= width) {
    xPos = 0;
  }
 
  delay(250);
}
 
void getNewTweets()
{
  try
  {
    Query query = new Query(searchString);
 
    QueryResult result = twitter.search(query);
 
    tweets = result.getTweets();
  }
  catch (TwitterException te)
  {
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}
 
void refreshTweets()
{
  while (true)
  {
    getNewTweets();
 
    println("Updated Tweets");
 
    delay(3000);
  }
}