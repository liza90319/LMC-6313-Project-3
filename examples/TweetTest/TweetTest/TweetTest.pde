//Twitter4j Test.

import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

//Variables used for connecting to Twitter and retrieving search results.
Twitter twitter;
List<Status> tweets;

String searchString;
List<Status> tweets1;
String searchString1;
List<Status> tweets2;
String searchString2;
List<Status> tweets3;
String searchString3;


//---Twitter connection methods.----

void setupTwitterConnection()
{
    
    ConfigurationBuilder cb = new ConfigurationBuilder();
    
    //Include your codes inside these 4 functions.
    cb.setOAuthConsumerKey("SSLkyRqHSnQr7i88dp1oDk5FN");     
    cb.setOAuthConsumerSecret("Woa1Yjx116bb6Qwdn20wmhpmdHpmxcBwD60bKlq7QMVDIsL93n");
    cb.setOAuthAccessToken("480462489-u1LZwX7mCdEpDgIHnFHg7XwA5CndcpZSrPqhzN7F");
    cb.setOAuthAccessTokenSecret("X63iEo292Soc3ZDFvD701zlWqzLoyHdqRwMzInZhbg7kS");

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

DisplayTweet test1;
DisplayTweet test2;
DisplayTweet test3;

void setup()
{ 
    //1. SETTING UP TWITTER CONNECTION.
    size(800,600);   
    setupTwitterConnection();
    println("Testing a tweet search.");
    
    //2. GETTING TWEETS
    searchString= "Atlanta";
    searchString1="mud OR upset";
    searchString2="@TomorroWworld";
    searchString3=searchString1+" AND "+searchString2;
    tweets=getTweets(searchString);
    tweets1= getTweets(searchString1);
    tweets2= getTweets(searchString2);
    tweets3= getTweets(searchString3);
    println(tweets1.get(0).getText());
    println(tweets2.get(0).getText());
    println(tweets3.get(0).getText());
    
      //Checking that our search returns at least one tweet.
      if(tweets.size()>0)
      {
          println("The first tweet for the search: "+searchString + " is:");
          println(tweets.get(0).getText());
      }
      
      else {
          println("No tweets were found.");
      }
      
       if(tweets1.size()>0)
      {
          println("The first tweet for the search: "+searchString1 + " is:");
          println(tweets1.get(0).getText());
      }
      
      else {
          println("No tweets were found.");
      }
      
       if(tweets2.size()>0)
      {
          println("The second tweet for the search: "+searchString2 + " is:");
          println(tweets2.get(0).getText());
      }
      
      else {
          println("No tweets were found.");
      }
      
       if(tweets3.size()>0)
      {
          println("The third tweet for the search: "+searchString3 + " is:");
          println(tweets3.get(0).getText());
      }
      
      else {
          println("No tweets were found.");
      }
           
      //3. INITIALIZE THE DISPLAY TWEET OBJECTS
        tweets1 = new DisplayTweet (width/2,height/2,tweets.get(0).getText(),15, color(255,0,0));
        tweets2 = new DisplayTweet (width/3,height/3,tweets.get(7).getText(),15, color(0,255,0));
}

void draw(){
  background(240);
  tweets1.drawMe();
  tweets2.drawMe();
  tweets3.drawMe();
  
}
