#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'
require '~/document/kasumikobot/userconf.rb'
 
follower_ids = []
@client.follower_ids(USERNAME).each do |id|
  follower_ids.push(id)
end
 
friend_ids = []
@client.friend_ids(USERNAME).each do |id|
  friend_ids.push(id)
end
 
@client.follow(follower_ids - friend_ids)
