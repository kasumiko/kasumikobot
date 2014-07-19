# encoding: utf-8
require 'twitter'
require 'tweetstream'

API_KEY = "rAm3o82TQj1sAEG1DUbeoT668"
API_SECRET = "3rNew1xhd9J3iq4slhtopFAFhImjMv8eKwNH1qrETbyqokjgFW"
ACCESS_TOKEN = "1617849072-eY4gFy0Awq0Z7atIQFNSabqtiRTufFuuyrnKs0W"
ACCESS_TOKEN_SECRET =  "TVFAvEJds2KdF7hFp3XbFmLgknG5020xPcMXByNE59iQi"

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = API_KEY
  config.consumer_secret     = API_SECRET
  config.access_token        = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end

TweetStream.configure do |config|
	config.consumer_key = API_KEY
	config.consumer_secret = API_SECRET
	config.oauth_token = ACCESS_TOKEN
	config.oauth_token_secret = ACCESS_TOKEN_SECRET
	config.auth_method = :oauth
end

Streamclient = TweetStream::Client.new
Streamclient.userstream do |status|
username = status.user.screen_name
contents = status.text
id = status.id
name = status.user.name	
locate = status.user.location
str = username + ":" + contents
puts str



end
