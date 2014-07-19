#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require "twitter"

MY_CONSUMER_KEY = "rAm3o82TQj1sAEG1DUbeoT668"
MY_CONSUMER_SECRET = "3rNew1xhd9J3iq4slhtopFAFhImjMv8eKwNH1qrETbyqokjgFW"
MY_ACCESS_TOKEN = "1617849072-eY4gFy0Awq0Z7atIQFNSabqtiRTufFuuyrnKs0W"
MY_ACCESS_TOKEN_SECRET =  "TVFAvEJds2KdF7hFp3XbFmLgknG5020xPcMXByNE59iQi"


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
