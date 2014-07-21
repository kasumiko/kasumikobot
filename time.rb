#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require "twitter"
require "tweetstream"
require '~/document/kasumikobot/userconf.rb'

t=Time.now

@client.update("#{t.hour}時だよ〜〜〜")

#twit = @client.user_timeline("Kasu_miko")
#twit.each do|tweet|
#text = tweet.text
#puts text
#end
