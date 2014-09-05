# encoding: utf-8

#声優ガチャ
def sayyou(actor,username,id,status)
 dir = Dir.entries("./#{actor}").sample
 @client.update_with_media("#{"@" + username}", open(File.expand_path("../#{actor}/#{dir}",__FILE__)),:in_reply_to_status_id => id)
 fav(status)
end

#ゆいおぐらガチャ
def ogura(username,status,id)
  actor = "yui"
 sayyou(actor,username,id,status)
 counter(username)
end

#ゆいおぐらガチャ(n連)
def nogura(contents,username,status,id)
  mem =PStore.new('memory.ps')
  mem.transaction do
   if mem[username] == nil
    name = contents.slice(/(ゆいおぐら).+(連)(ガチャ)/).gsub(/(ゆいおぐら)|(連)(ガチャ)/,"").tr('１-９','1-9')
    actor="yui"
    n=name.to_i
    if n < 11 then
     dir = Dir.entries("./#{actor}")
     n.times do
      @client.update_with_media("#{"@" + username}", open(File.expand_path("../#{actor}/#{dir.sample}",__FILE__)),:in_reply_to_status_id => id)
     end
     mem[username] = 0
     db = PStore.new('counter.ps')
     db.transaction do
      if db[username] == nil
       db[username]=1
      else
       db[username] += n
      end
     end
    else
    reply("#{"@" + username} そんなにいっぱい出せないよぅ…#{"\u00A0"*rand(5)}",id)
    end
   else  
    reply("#{"@" + username} 引きすぎは身体にわるいよ？#{"\u00A0"*rand(5)}",id)
   end
  end
end

#ゆいおぐらガチャ(応援)
def cheerogura(username,status,id)
  dir = Dir.entries("./yui").sample
  @client.update_with_media("#{"@" + username} がんばって！", open(File.expand_path("../yui/#{dir}",__FILE__)),:in_reply_to_status_id => id)    
   fav(status)   
end 

#野中藍ガチャ
def aipon(username,status,id)
  actor = "aipon"
 sayyou(actor,username,id,status)
end

#カウンタ
def counter(username)
 db = PStore.new('counter.ps')
  db.transaction do
  if db[username] == nil
   db[username]=1
  else
   db[username] += 1
  end
 end
end

#ゆいおぐらカウンタ
def yuicounter(username,status,id)
  db = PStore.new('counter.ps')
  db.transaction do
   if db[username] == nil
    db[username]=0
    reply("#{"@"+username} あなたはまだゆいおぐらガチャをしていません。",id)
   else
    reply("#{"@"+username} あなたは#{db[username]}回ゆいおぐらガチャをしました。",id)
   end
  end
end


#ゆいおぐらランク
def ranker(username,status,id)
  rank = PStore.new('ranker.ps')
  rank.transaction do
   if rank[username] == nil
    reply("#{"@"+username} あなたはまだゆいおぐらガチャをしていません。",id)
   else
    reply("#{"@"+username} あなたはゆいおぐらんく#{rank[username]}位です！",id)
   end
  end
  fav(status)
end
