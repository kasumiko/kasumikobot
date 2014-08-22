# encoding: utf-8

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
def yuicounter(contents,username,status,id)
 if contents =~ /ゆいおぐらカウンタ/
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
end

#ハピクレ
def happy(contents,username,status,id)
 if contents =~ /ハッピークレセント|ハピクレ/	
  reply("#{"@" + username} 永遠ロマンス！#{"\u00A0"*rand(20)}",id)	
  fav(status)
 end
end

#声優ガチャ
def sayyou(actor,username,id,status)
 dir = Dir.entries("./#{actor}").sample
 @client.update_with_media("#{"@" + username}", open(File.expand_path("../#{actor}/#{dir}",__FILE__)),:in_reply_to_status_id => id)
 fav(status)
end

#ゆいおぐらガチャ
def ogura(contents,username,status,id)
 if contents =~ /((ゆい|唯|ユイ|yui|YUI|ﾕｲ|Yui)(Ogura|ｵｸﾞﾗ|オグラ|ogura|おぐら|OGURA|おぐらちゃん|小倉ちゃん|小倉|ゆい|yui|ﾕｲ|Yui)|(Ogura|ｵｸﾞﾗ|ogura|OGURA|おぐら|小倉|オグラ)(Yui|ﾕｲ|ゆい|唯|ユイ|YUI|yui|ゆいちゃん|唯ちゃん|ﾕｲちゃん|ﾕｲﾁｬﾝ)|台乙|台乙先生|ゆい\(\*-v・\)ゆい|唯ちゃん|おぐゆい|だいおつ|だい\(\*-v・\)おつ)(ガチャ|がちゃ|ｶﾞﾁｬ)|がちゃおぐら/
  actor = "yui"
 sayyou(actor,username,id,status)
 counter(username)
 end
end

#ゆいおぐらガチャ(n連)
def nogura(contents,username,status,id)
 if contents =~ /(ゆいおぐら).+(連)(ガチャ)/
  name = contents.slice(/(ゆいおぐら).+(連)(ガチャ)/).gsub(/(ゆいおぐら)|(連)(ガチャ)/,"").tr('１-９','1-9')
  actor="yui"
  n=name.to_i
  if n < 11 then
   dir = Dir.entries("./#{actor}")
   n.times do
   @client.update_with_media("#{"@" + username}", open(File.expand_path("../#{actor}/#{dir.sample}",__FILE__)),:in_reply_to_status_id => id)
   end
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
  fav(status)
 end
end

#ゆいおぐらガチャ(応援)
def cheerogura(contents,username,status,id)
 if contents =~ /もう(ダメ|だめ)だ/
  dir = Dir.entries("./yui").sample
  @client.update_with_media("#{"@" + username} がんばって！", open(File.expand_path("../yui/#{dir}",__FILE__)),:in_reply_to_status_id => id)    
   fav(status)   
 end
end 

#野中藍ガチャ
def aipon(contents,username,status,id)
 if contents =~ /((のなか|あい|野中|藍)(のなか|あい|野中|藍)|あいぽん|アイポン|ｱｲﾎﾟﾝ)(ガチャ|がちゃ)/
  actor = "aipon"
 sayyou(actor,username,id,status)
 end
end

#出席ガチャ
def attend(contents,username,status,id,name)
 if contents =~ /(出席|欠席)(ガチャ|がちゃ)/
  pro = rand(1..100)
  case pro
   when 1..4 then
    reply("#{"@" + username}\n  #{name+"は留年です！\n来年も頑張りましょう！"}",id)
   when 5..100 then
    ans = ""
    ress = ""
     6.times { |x|
      num = rand(1..10)
       case num
        when 1..7 then
         ress = "出席"
        when 8..10 then
         ress = "欠席"
       end
      result = "\n #{x+1}限  " + ress.to_s
      ans += result
     }
    reply("#{"@" + username}\n  #{name+"の今日の出席"} " + ans.to_s + "です。\n今日も一日がんばりましょう！",id)
   end
  fav(status)
 end
end

#"かすかたんガチャ"に反応して怒る
def kaska(contents,username,status,id)
 if contents =~ /(かすかたん|こまき|かすか|駒木悠平|コマキ|かすみこ)ガチャ/
  reply("#{"@" + username} うっせーばーか#{"！" * rand(1..10)}",id)
  fav(status)
 end
end

#土橋ガチャ
def yumehikari(contents,username,status,id)
 if contents =~ /(土橋|どばし|ゆめひかり|土橋輝)(ガチャ|がちゃ|ｶﾞﾁｬ)/
  count = 0
  fp = open(File.expand_path('../dobashi.txt',__FILE__))
   while fp.gets
    count += 1
   end
  open(File.expand_path('../dobashi.txt',__FILE__)) do |f|
   post("#{"@" + username} " + f.readlines[rand(count)], :in_reply_to_status_id => id)
   fav(status)
  end 
 end
end


#今日のアルカナ
def arcana(contents,username,status,id,name)
 if contents =~ /今日のアルカナ/
  arcana = ["愚者-The FOOL-", "魔術師-The MAGICIAN-", "女教皇-The HIGHPRIESTESS-", "女帝-The EMPRESS-", "皇帝-The EMPEROR-", "法王-The HIEROPHANT-", "恋愛-The LOVERS-", "戦車-The CHARIOT-", "正義-The JUSTICE-", "隠者-The HERMIT-", "運命-The WHEEL OF FORTUNE-", "剛毅-The STRENGTH-", "刑死者-The HANGEDMAN-", "死神-The DEATH-", "節制-The TEMPERANCE-", "悪魔-The DEVIL-", "塔-The TOWER-", "星-The STAR-", "月-The MOON-", "太陽-The SUN-", "審判-The JUDGEMENT-", "世界-The WORLD-", "永劫-The AEON-", "道化師-The JOKER-", "欲望-The DESIRE-"]
  reply("#{"@" + username} " + name +"さんのアルカナは #{arcana.sample} です。",id)
  fav(status)
 end
end

#"たかまり"に反応して、一日ワンチャンアシカﾓﾉﾏﾈチャンスを返す
def raise(contents,username,status,id)
 if contents =~ /たかまる|ﾀｶﾏﾙ|タカマル|高まる/
  reply("#{"@" + username} ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ ﾀ゛ｶ゛ﾏ゛ﾙ゛ #一日ワンチャンアシカﾓﾉﾏﾈチャンス",id)
  fav(status)
 end
end

#ぬるぽがっ
def nurupo(contents,username,status,id)
 if contents =~ /ぬるぽ|ヌルポ|ﾇﾙﾎﾟ/
  reply("#{"@" + username} ｶﾞｯ#{"\u00A0"*rand(5)}",id)
  fav(status)	
 end
end

#今日のラーメン
def ramen(contents,username,status,id,name)
 if contents =~ /ラーメン食べたい/
  num = rand(1..5)
  ramen = ""
  menu = []	
  case num
   when 1 then
    ramen = "龍郎"
    menu = ["ラーメン","まぜそば","味噌ラーメン"]	
   when 2 then
    ramen = "鶏々"
    menu = ["鶏白湯 塩","鶏白湯 醤油","鶏つけ麺 塩","鶏つけ麺 醤油"]
   when 3 then
    ramen = "清六家"
    menu = ["極み鶏"]
   when 4 then
    ramen = "油虎"
    menu = ["油そば","油そば肉のせ","油そばジャンク盛り","汁なし坦々まぜそば"]
   when 5 then
    ramen = "蒼"
    menu = ["つけ麺","卵かけつけ麺","海老香味ラーメン","汁なしそば"]
  end
  reply("#{"@" + username} 今日" + name + "さんが食べるラーメンは#{ramen + "の" + menu.sample}です。",id)
  fav(status)
 end
end

#ゆーきがブロックされる
def yuki(contents,username,status,id)
 if contents =~ /ゆーきブロックガチャ/
  reply("#{"@" + username} ゆーきくん(@yu_ki_kun_1)は#{rand(1000)}人にブロックされています。",id)
  fav(status)
 end
end

#うっぱがスパムされる
def uppa(contents,username,status,id)
 if contents =~ /うっぱスパムしよ/
  reply("#{"@" + username} うっぱは#{rand(1000)}人にブロックされました。",id)
  fav(status)	
 end
end

#"Let's fly now"したら"Let's try now"する
def rimfire(contents,username,status,id)
 if contents =~ /let's fly now/i
  reply("#{"@" + username} Let's try now#{"！" * rand(1..10)}",id)
 fav(status)
 end
end

#今日のロデオ
def rodeo(contents,username,status,id)	
if contents =~ /今日の(ロデオ|ろでお|RODEO|rodeo|granrodeo|GRANRODEO|グランロデオ|ｸﾞﾗﾝﾛﾃﾞｵ|GR|グラロデ|ぐらろで|ｸﾞﾗﾛﾃﾞ|KISHOW|kishow|e-ZUKA|e-zuka|val|VAL|たきた|瀧田)/
 count = 0
 fp = open(File.expand_path('../rodeo.txt',__FILE__))
  while fp.gets
   count += 1
  end
  open(File.expand_path('../rodeo.txt',__FILE__)) do |f|
   reply("#{"@" + username} 今日あなたにおすすめのGRANRODEOの曲は\n" + f.readlines[rand(count)],id)
   fav(status)	
  end 
 end
end

#ん？今	
def nandemo(contents,username,status,id)
 if contents =~ /(何|なん)でもする|(なん|何)でもします/
  reply("#{"@" + username} ん？今なんでもするって言ったよね？#{"\u00A0"*rand(5)}",id)
  fav(status)        
 end
end

#Yo
#def yo
# if contents.gsub(/@[a-zA-Z0-9_]+\s/,"") =~ /Yo|yo/
#  post("#{"@" + username} Yo#{"\u00A0"*rand(10)}" ,:in_reply_to_status_id => id)
#  fav(status)	
# end
#end

#namechange
def namechange(contents,username,status,id)
 if contents =~ /\(@kasumikobot\)/
  name = contents.gsub(/\(@kasumikobot\)/,"")
  if name.length > 20 then
   name = name[0,20]
   @client.update_profile(name: "#{name}")
   reply("#{"@" + username} 今から俺の名前は#{name}だ！",id)
  elsif name.length == 1 then
   reply("#{"@" + username} 短すぎるよぉ…",id)
  else
   @client.update_profile(name: "#{name}")
   reply("#{"@" + username} 今から俺の名前は#{name}だ！",id)
  end
  fav(status)
 end
end	

#ふぁぼれよ
def favre(contents,status)
 if contents =~ /ふぁぼれよ/
  fav(status)
 end
end
	
#"現在の名前"に反応して、"はい"とリプライを返す
def answer(contents,status,username,id)
 if contents =~ /かすかたんbot/
  reply("#{"@" + username} はい#{"\u00A0"*rand(10)}",id)
  fav(status)	
 end
end

#人の顔が見たい
def fx(contents,username,id,status)
 if contents =~ /の顔が(見|み)たいよ/
  @client.update_with_media("#{"@" + username}", open(File.expand_path("../pic#{rand(1..2)}.png",__FILE__)), :in_reply_to_status_id => id)
  fav(status)
 end
end

#あいさつ
def greet(contents,username,name,id,status)
 if contents =~ /おはよう|起きた|おはよー/
  morn = ["おっはよ〜", "おはよー", "おはようございます", "おはよう", "おはよーございまーす", "おはよ〜"]
  reply("@" + username + " " + morn.sample+"！ " + name + "さん！",id)
  fav(status)
 end
 if contents =~ /寝る|おやすみ/
  morn = ["おやすみ〜", "おやすみ", "おやすみなさい", "おやすみです", "今日はもう寝るんですか？", "また明日"]
  reply("@" + username + " " + morn.sample+"！ " + name + "さん！",id)
  fav(status)	
 end
end

#突然の死
def suddenly(contents,username,id,status)
 if contents =~ /suddenly/
  moji = contents.gsub(/@kasumikobot|　|suddenly|\s/,"")
  n = moji.chomp.bytesize
  w = n/2
  reply("#{"@" + username } \n＿#{"人"*w}＿\n＞　#{moji}　＜\n￣#{"Y^"*w}￣\n",id)
 fav(status)
 end
end

#燃やす
def lmf(contents,username,id,status)
 if contents =~ /Light my fire|LMF/i
  moji = contents.gsub(/@kasumikobot|　|Light my fire|\s|LMF/,"")
  w = moji.chomp.length
  reply("#{"@" + username } \n🔥#{"🔥"*w}🔥\n🔥#{moji}🔥\n🔥#{"🔥"*w}🔥\n",id)
 end
end

#"What time"に反応して現在の時刻(JST)を返す
def whattime(contents,username,id,status)
 if contents =~ /what time/i
  clo = Time.now
  reply("#{"@" + username } " + clo.to_s ,id)	
 end
end

#"Where am I"に反応してUserのlocationを返す
def wherei(contents,username,locate,id)
 if contents =~ /Where am I/i
  reply("#{"@" + username } " + locate ,id)
 end
end

#"Who am I"に反応してUserのnameを返す
def whoi(contents,username,name,id)
 if contents =~ /who am I/i
  reply("#{"@" + username } " + name ,id)
 end
end

#コイントス
def cointoss(contents,username,id)
 if contents =~ /コイントス/
  coin = rand(1..2)
  case coin
   when 1 then
    reply("#{"@" + username} 表です。 #{"\u00A0"*rand(5)}" ,id)
   when 2 then
    reply("#{"@" + username} 裏です。 #{"\u00A0"*rand(5)}" ,id)
  end
 end
end

#ダイスロール
def diceroll(contents,username,id)
 if contents =~ /\dD\d/
  dice = contents.gsub(/@kasumikobot |　/,"")
   time = dice[0,2].to_i
   number = dice[-1,2].to_i
  result = 1 + rand(number*time).to_i
   post("#{"@" + username} #{result.to_i}" ,:in_reply_to_status_id => id)
 end
end

=begin  
#書き込み
def writer(contents,username,id)
 if contents =~ /アニメw/
  contents = contents.gsub(/@kasumikobot アニメw\n/,"")  
  content = contents.split(",")
  data = [username => content]
  YAML.dump(data, open(File.expand_path('../test1.yml',__FILE__), "a"))
  post("#{"@"+username} 記憶したよ#{"！"*rand(5)}",:in_reply_to_status_id => id)
 end
end

#取り出し
def reader(contents,username,id)
 if contents =~ /アニメr/
  data = YAML.load_stream(File.expand_path('../test1.yml',__FILE__))
  puts data.class.to_s
 end
end
=end

#ｾｯｸｽ
def sex(contents,username,id,status)
 if contents == "ｾｯ"
  arr = ["ｸｽ","ﾌﾟｸ","ｶｲ","ｺｳ","ｸﾂ","ﾍﾟﾝ","ﾃﾝ","ｹﾝ","ﾌﾟﾝ","ｶﾝ","ﾄｳ","ﾃｲ","ｸｽ","ﾃﾝ"]
  reply(arr.sample+" RT @"+username+": "+contents,id)
 end
end

#ゆれ
def earthquake(contents,username,status)
 if contents =~ /ゆれ/
  post("ウーッ！ウーッ！ウーッ！ 緊急事態発生！緊急事態発生！ 直ちにちんちんを格納してください！ ウーッ！ウーッ！ウーッ！ 緊急事態発生！緊急事態発生！ 直ちにちんちんを格納してください！ ウーッ！ウーッ！ウーッ！")
 end
end

#今日のペルソナ
def persona(contents,username,id)
 if contents =~ /ペルソナ！|ペルソナッ！|カッ！|ｶｯ!|ﾍﾟﾙｿﾅ!|ﾍﾟﾙｿﾅｯ!/
  count = 0
  fp = open(File.expand_path('../persona/arcana.txt',__FILE__))
  while fp.gets
   count += 1
   num = rand(count)
  end
  file = "../persona/#{num}"
  count2 = 0
  ft = open(File.expand_path(file,__FILE__))
  while ft.gets
   count2 += 1
  end
  open(File.expand_path('../persona/arcana.txt',__FILE__)) do |f|
   open(File.expand_path(file,__FILE__)) do |p|
    reply("#{"@" + username} \n\n#{f.readlines[num]} \n#{p.readlines[rand(count2)]}",id)
   end
  end
 end
end

#今日の斬魄刀
def zanpakutou(contents,username,status,id)	
 if contents =~ /今日の斬魄刀/
 count = 0
 fp = open(File.expand_path('../zanpaku.txt',__FILE__))
  while fp.gets
   count += 1
  end
  open(File.expand_path('../zanpaku.txt',__FILE__)) do |f|
   reply("#{"@" + username} \n" + f.readlines[rand(count)],id)
   fav(status)
  end 
 end
end
=begin
#簡易計算機
def calc(contents,username,status,id)
 if contents =~ /@kasumikobot Ruby/
 code = contents.sub(/@kasumikobot Ruby /,"")
 reply("#{"@" + username} #{code}")
 end
end
=end
