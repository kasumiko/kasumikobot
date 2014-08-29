#!/usr/local/bin/ruby -Ku
# encoding: utf-8
require'pstore'
require'pp'
db = PStore.new(File.expand_path('../counter.ps',__FILE__))
db.transaction do
 data = Hash::new
 db.roots.each{|i|
  data[i] = db[i]
 }
 datus = []
 data.sort_by{|key,val| val}.each{|m|
  m << data.sort_by{|key,val| val}.index(m)+1
  datus << m
 }
 rank = PStore.new(File.expand_path('../ranker.ps',__FILE__))
 rank.transaction do
  datus.each{|n|
   rank[n[0]]=n[2]
  }
end
end
