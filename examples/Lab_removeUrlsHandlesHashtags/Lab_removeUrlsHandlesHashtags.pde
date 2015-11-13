//In this example, we use regular expressions to remove hashtags, urls or handles from a tweet.


String fakeTweet = "This is a fake tweet to @someone with the following link: http://www.google.com #project2 test test #test";

String urlPattern = "https?://.*( |$)"; //should find all URLs (unless someone posts a URL starting in ftp:// or some other, far less common protocol)
String handlePattern = "@([A-Za-z0-9_]{1,15})"; //looks for A-Z, a-z, 0-9, or _ in any combination between 1 and 15 characters long, following an @
String hashtagPattern = "#.*( |$)"; //looks for any characters following a # sign, and ending in a space or the end of the tweet
//(note that the above pattern also eliminates attempted-yet-not-actually-legal hashtags.. it's a simpler regex that way)

String modifiedTweet = "";

modifiedTweet = fakeTweet.replaceAll(urlPattern, ""); //replaces URLs with an empty string (this is the way to delete your pattern)
modifiedTweet = modifiedTweet.replaceAll(handlePattern, ""); //replaces user handles. note that I'm using modTweet, not fakeTweet
modifiedTweet = modifiedTweet.replaceAll(hashtagPattern,""); //replaces hashtags

println(fakeTweet);
println(modifiedTweet);
