#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'
 
API_KEY = "rAm3o82TQj1sAEG1DUbeoT668"
API_SECRET = "3rNew1xhd9J3iq4slhtopFAFhImjMv8eKwNH1qrETbyqokjgFW"
ACCESS_TOKEN = "1617849072-eY4gFy0Awq0Z7atIQFNSabqtiRTufFuuyrnKs0W"
ACCESS_TOKEN_SECRET =  "TVFAvEJds2KdF7hFp3XbFmLgknG5020xPcMXByNE59iQi"
USERNAME="kasumikobot"

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = API_KEY
  config.consumer_secret     = API_SECRET
  config.access_token        = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end

 
follower_ids = []
@client.follower_ids(USERNAME).each do |id|
  follower_ids.push(id)
end
 
friend_ids = []
@client.friend_ids(USERNAME).each do |id|
  friend_ids.push(id)
end
 
@client.follow(follower_ids - friend_ids)
