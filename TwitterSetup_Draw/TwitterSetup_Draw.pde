//Twitter4j Test.

//Files needed to use Twitter4j and java arrays.
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

//Variables used for connecting to Twitter and retrieving search results.
Twitter twitter;
List<Status> tweets;
String searchString;

//Putting the DisplayTweet object here.
DisplayTweet tweet1;


//---Twitter connection methods.----
void setupTwitterConnection()
{
    
    ConfigurationBuilder cb = new ConfigurationBuilder();
    
    //Include your twitter display codes inside these 4 functions.
    cb.setOAuthConsumerKey();     
    cb.setOAuthConsumerSecret();
    cb.setOAuthAccessToken();
    cb.setOAuthAccessTokenSecret();

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();

    println("setupTwitterConnection(): Done setting up.");
    
}

List<Status> getTweets(String mySearch)
{
    
    List<Status> resultTweets= new ArrayList<Status>();
    
    try 
    {
        
        Query query = new Query(mySearch);
        QueryResult result = twitter.search(query);

        resultTweets= result.getTweets();
    } 
    
    catch (TwitterException te) 
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    } 
   
    return resultTweets;

}


void setup()
{
  
    //1. -------Setting up twitter connection.
    size(800,600);
    
    setupTwitterConnection();

    println("Testing a tweet search.");

    //2. --------Getting tweets.
    searchString= "Atlanta";
    tweets=getTweets(searchString);
    
      //Checking that our search returns at least one tweet.
      if(tweets.size()>0)
      {
          println("The first tweet for the search: "+searchString + " is:");
          println(tweets.get(0).getText());
      }
      
      else
          println("No tweets were found.");
      
        
     //3. ---------Initializing the Display Tweets.
           tweet1 =   new DisplayTweet (width/2, 
                             height/2, 
                             tweets.get(0).getText(), 
                             15, 
                             color(255,0,0));
                                        
}

void draw()
{
  
    background(240);

    //Using the DisplayTweet's draw method for display.
    tweet1.drawMe();
  
   
}


