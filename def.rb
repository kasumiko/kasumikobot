# encoding: utf-8
#Tweetする
def post(post,option={})
@client.update(post,option={})
end

#favる
def fav(status)
@client.favorite(status)
end

#ハピクレ
def happy(contents,username,status,id)
 if contents =~ /ハッピークレセント|ハピクレ/	
  post("#{"@" + username} 永遠ロマンス！#{"\u00A0"*rand(20)}", :in_reply_to_status_id => id)	
  fav(status)
 end
end

#ゆゆ式は神アニメ
def yuyu(contents,username,status,id)
 if contents =~ /ゆゆ式/
  post("#{"@" + username} ゆゆ式は神アニメ "+"\u00A0"*rand(20), :in_reply_to_status_id => id)
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
 end
end

#ゆいおぐらガチャ(n連)
def nogura(contents,username,status,id)
 if contents =~ /(ゆいおぐら).+(連)(ガチャ)/
  name = contents.gsub(/ゆいおぐら/,"").gsub(/連ガチャ/,"")
  n=name.to_i
  if n < 21 then
   n.times do
   dir = Dir.entries("./yui").sample
   @client.update_with_media("#{"@" + username}", open(File.expand_path("../yui/#{dir}",__FILE__)),:in_reply_to_status_id => id)    
   end
  else
   post("#{"@" + username} そんなにいっぱい出せないよぅ…#{"\u00A0"*rand(5)}", :in_reply_to_status_id => id)
  end
  fav(status)
 end
end


#ゆいおぐらガチャ(応援)
def cheerogura(contents,username,status,id)
 if contents =~ /もう(ダメ|だめ)だ/
  dir = Dir.entries("./yui").sample
  @client.update_with_media("#{"@" + username}", open(File.expand_path("../yui/#{dir}",__FILE__)),:in_reply_to_status_id => id)    
   fav(status)   
 end
end 

#野中藍ガチャ
def aipon(contents,username,status,id)
 if contents =~ /((のなか|あい|野中|藍)(のなか|あい|野中|藍)|あいぽん)ガチャ/
  dir = Dir.entries("./aipon").sample
  @client.update_with_media("#{"@" + username}", open(File.expand_path("../aipon/#{dir}",__FILE__)),:in_reply_to_status_id => id)
 fav(status)
 end
end

#出席ガチャ
def attend(contents,username,status,id,name)
 if contents =~ /(出席|欠席)(ガチャ|がちゃ)/
  pro = rand(1..100)
  case pro
   when 1..4 then
    post("#{"@" + username}\n  #{name+"は留年です！\n来年も頑張りましょう！"}", :in_reply_to_status_id => id)
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
    post("#{"@" + username}\n  #{name+"の今日の出席"} " + ans.to_s + "です。\n今日も一日がんばりましょう！", :in_reply_to_status_id => id)
   end
  fav(status)
 end
end

#"かすかたんガチャ"に反応して怒る
def kaska(contents,username,status,id)
 if contents =~ /かすかたんガチャ/
  post("#{"@" + username} うっせーばーか#{"！" * rand(1..10)}", :in_reply_to_status_id => id)
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
  post("#{"@" + username} " + name +"さんのアルカナは #{arcana.sample} です。", :in_reply_to_status_id => id)
  fav(status)
 end
end

#"たかまり"に反応して、一日ワンチャンアシカﾓﾉﾏﾈチャンスを返す
def raise(contents,username,status,id)
 if contents =~ /たかまる|ﾀｶﾏﾙ|タカマル|高まる/
  post("#{"@" + username} ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ ﾀ゛ｶ゛ﾏ゛ﾙ゛ #一日ワンチャンアシカﾓﾉﾏﾈチャンス", :in_reply_to_status_id => id)
  fav(status)
 end
end

#ぬるぽがっ
def nurupo(contents,username,status,id)
 if contents =~ /ぬるぽ|ヌルポ|ﾇﾙﾎﾟ/
  post("#{"@" + username} ｶﾞｯ#{"\u00A0"*rand(5)}", :in_reply_to_status_id => id)
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
  post("#{"@" + username} 今日" + name + "さんが食べるラーメンは#{ramen + "の" + menu.sample}です。", :in_reply_to_status_id => id)
  fav(status)
 end
end

#ゆーきがブロックされる
def yuki(contents,username,status,id)
 if contents =~ /ゆーきブロックガチャ/
  post("#{"@" + username} ゆーきくん(@yu_ki_kun_1)は#{rand(1000)}人にブロックされています。", :in_reply_to_status_id => id)
  fav(status)
 end
end

#うっぱがスパムされる
def uppa(contents,username,status,id)
 if contents =~ /うっぱスパムしよ/
  post("#{"@" + username} うっぱは#{rand(1000)}人にブロックされました。", :in_reply_to_status_id => id)
  fav(status)	
 end
end

#"Let's fly now"したら"Let's try now"する
def rimfire(contents,username,status,id)
 if contents =~ /(Let's|let's) (fly|Fly) (now|Now)/
  post("#{"@" + username} Let's try now#{"！" * rand(1..10)}", :in_reply_to_status_id => id)
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
   post("#{"@" + username} 今日あなたにおすすめのGRANRODEOの曲は\n" + f.readlines[rand(count)], :in_reply_to_status_id => id)
   fav(status)	
  end 
 end
end

#ん？今	
def nandemo(contents,username,status,id)
 if contents =~ /(何|なん)でもする|(なん|何)でもします/
  post("#{"@" + username} ん？今なんでもするって言ったよね？#{"\u00A0"*rand(5)}", :in_reply_to_status_id => id)
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
   post("#{"@" + username} 今から俺の名前は#{name}だ！", :in_reply_to_status_id => id)
  elsif name.length == 1 then
   post("#{"@" + username} 短すぎるよぉ…", :in_reply_to_status_id => id)
  else
   @client.update_profile(name: "#{name}")
   post("#{"@" + username} 今から俺の名前は#{name}だ！", :in_reply_to_status_id => id)
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
def answer(contents,status,username,myname,id)
 if contents =~ /#{myname}|かすかたんbot/
  post("#{"@" + username} はい#{"\u00A0"*rand(10)}", :in_reply_to_status_id => id)
  fav(status)	
 end
end

#人の顔が見たい
def fx(contents,username,id,status)
 if contents =~ /の顔が見たいよ/
  @client.update_with_media("#{"@" + username}", open(File.expand_path("../pic#{rand(1..2)}.png",__FILE__)), :in_reply_to_status_id => id)
  fav(status)
 end
end

#あいさつ
def greet(contents,username,name,id,status)
 if contents =~ /おはよう|起きた|おはよー/
  morn = ["おっはよ〜", "おはよー", "おはようございます", "おはよう", "おはよーございまーす", "おはよ〜"]
  post("@" + username + " " + morn.sample+"！ " + name + "さん！",:in_reply_to_status_id => id)
  fav(status)
 end
 if contents =~ /寝る|おやすみ/
  morn = ["おやすみ〜", "おやすみ", "おやすみなさい", "おやすみです", "今日はもう寝るんですか？", "また明日"]
  post("@" + username + " " + morn.sample+"！ " + name + "さん！",:in_reply_to_status_id => id)
  fav(status)	
 end
end

#突然の死
def suddenly(contents,username,id,status)
 if contents =~ /suddenly/
  moji = contents.gsub(/@kasumikobot|　|suddenly|\s/,"")
  n = moji.chomp.bytesize
  w = n/2
  post("#{"@" + username } \n＿#{"人"*w}＿\n＞#{moji}＜\n￣#{"Y^"*w}￣\n", :in_reply_to_status_id => id)
 fav(status)
 end
end

#燃やす
def lmf(contents,username,id,status)
 if contents =~ /Light my fire|LMF/
  moji = contents.gsub(/@kasumikobot|　|Light my fire|\s|LMF/,"")
  w = moji.chomp.length
  post("#{"@" + username } \n🔥#{"🔥"*w}🔥\n🔥#{moji}🔥\n🔥#{"🔥"*w}🔥\n", :in_reply_to_status_id => id)
 end
end

#"What time"に反応して現在の時刻(JST)を返す
def whattime(contents,username,id,status)
 if contents =~ /(what|What) time/
  clo = Time.now
  post("#{"@" + username } " + clo.to_s ,:in_reply_to_status_id => id)	
 end
end

#"Where am I"に反応してUserのlocationを返す
def wherei(contents,username,locate,id)
 if contents =~ /(where|Where) am I/
  post("#{"@" + username } " + locate ,:in_reply_to_status_id => id)
 end
end

#"Who am I"に反応してUserのnameを返す
def whoi(contents,username,name,id)
 if contents =~ /(who|Who) am I/
  post("#{"@" + username } " + name ,:in_reply_to_status_id => id)
 end
end

#コイントス
def cointoss(contents,username,id)
 if contents =~ /コイントス/
  coin = rand(1..2)
  case coin
   when 1 then
    post("#{"@" + username} 表です。 #{"\u00A0"*rand(5)}" ,:in_reply_to_status_id => id)
   when 2 then
    post("#{"@" + username} 裏です。 #{"\u00A0"*rand(5)}" ,:in_reply_to_status_id => id)
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
   post("#{"@" + username} #{result.to_i
}" ,:in_reply_to_status_id => id)
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
