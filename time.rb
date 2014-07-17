#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require "twitter"

MY_CONSUMER_KEY = ""
MY_CONSUMER_SECRET = ""
MY_ACCESS_TOKEN = ""
MY_ACCESS_TOKEN_SECRET =  ""


@client = Twitter::REST::Client.new do |config|

config.consumer_key = MY_CONSUMER_KEY
config.consumer_secret = MY_CONSUMER_SECRET
config.access_token = MY_ACCESS_TOKEN
config.access_token_secret = MY_ACCESS_TOKEN_SECRET
end
t=Time.now

@client.update("#{t.hour}時だよ〜〜〜")

#twit = @client.user_timeline("Kasu_miko")
#twit.each do|tweet|
#text = tweet.text
#puts text
#end
