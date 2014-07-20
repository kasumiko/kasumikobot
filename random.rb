#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require "twitter"
require '~/document/kasumikobot/userconf.rb'


open(File.expand_path('../text.dat',__FILE__)) do |f|
@client.update(f.readlines.sample)
end

