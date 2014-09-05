# encoding: utf-8
require'pstore'
require '~/document/kasumikobot/userconf.rb'
require 'twitter'

i = nil
if Time.now.wday === 1..5
i = Time.now.wday-1
end
i = 0
tt = PStore.new('timetable.ps')
tt.transaction do
 tt.roots.each{|username|
 post = "@#{username}\n今日の時間割です。"
 tt[username][i].each_with_index{|n,j|
  sub = ""
  room = ""
  case n[0]
  when nil
   sub = "空きコマ　　　　"
  else
  sub = n[0]
  end
  case n[1]
  when nil
   room = ""
  else
  room = n[1]
  end
 post += "\n#{j+1}限 #{sub} #{room}"
 }
 @client.update(post)
 }
end

