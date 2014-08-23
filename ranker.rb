# encoding: utf-8
require'pstore'
require'pp'
db = PStore.new('counter.ps')
db.transaction do
 data = Hash::new
 db.roots.each{|i|
  data[i] = db[i]
 }
 datus = []
 data.sort.each{|m|
  m << data.sort.index(m)+1
  datus << m
 }
 rank = PStore.new('ranker.ps')
 rank.transaction do
  datus.each{|n|
   rank[n[0]]=n[2]
  }
pp rank["Kasu_miko"]
 end
end

