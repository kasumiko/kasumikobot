#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'
 
API_KEY = ""
API_SECRET = ""
ACCESS_TOKEN = ""
ACCESS_TOKEN_SECRET =  ""
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
