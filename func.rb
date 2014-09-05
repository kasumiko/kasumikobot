# encoding: utf-8

#ハピクレ
def happy(username,status,id)
  reply("#{"@" + username} 永遠ロマンス！#{"\u00A0"*rand(20)}",id)	
  fav(status)
end

#出席ガチャ
def attend(username,status,id,name)
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

#"かすかたんガチャ"に反応して怒る
def kaska(username,status,id)
  reply("#{"@" + username} うっせーばーか#{"！" * rand(1..10)}",id)
  fav(status)
end

#土橋ガチャ
def yumehikari(username,status,id)
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


#今日のアルカナ
def arcana(username,status,id,name)
  arcana = ["愚者-The FOOL-", "魔術師-The MAGICIAN-", "女教皇-The HIGHPRIESTESS-", "女帝-The EMPRESS-", "皇帝-The EMPEROR-", "法王-The HIEROPHANT-", "恋愛-The LOVERS-", "戦車-The CHARIOT-", "正義-The JUSTICE-", "隠者-The HERMIT-", "運命-The WHEEL OF FORTUNE-", "剛毅-The STRENGTH-", "刑死者-The HANGEDMAN-", "死神-The DEATH-", "節制-The TEMPERANCE-", "悪魔-The DEVIL-", "塔-The TOWER-", "星-The STAR-", "月-The MOON-", "太陽-The SUN-", "審判-The JUDGEMENT-", "世界-The WORLD-", "永劫-The AEON-", "道化師-The JOKER-", "欲望-The DESIRE-"]
  reply("#{"@" + username} " + name +"さんのアルカナは #{arcana.sample} です。",id)
  fav(status)
end

#"たかまり"に反応して、一日ワンチャンアシカﾓﾉﾏﾈチャンスを返す
def raise(contents,username,status,id)
 if contents =~ /たかまる|ﾀｶﾏﾙ|タカマル|高まる/
  reply("#{"@" + username} ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ ﾀ゛ｶ゛ﾏ゛ﾙ゛ #一日ワンチャンアシカﾓﾉﾏﾈチャンス",id)
  fav(status)
 end
end

#ぬるぽがっ
def nurupo(username,status,id)
  reply("#{"@" + username} ｶﾞｯ#{"\u00A0"*rand(5)}",id)
  fav(status)	
end

#今日のラーメン
def ramen(username,status,id,name)
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

#ゆーきがブロックされる
def yuki(username,status,id)
  reply("#{"@" + username} ゆーきくん(@yu_ki_kun_1)は#{rand(1000)}人にブロックされています。",id)
  fav(status)
end

#うっぱがスパムされる
def uppa(username,status,id)
  reply("#{"@" + username} うっぱは#{rand(1000)}人にブロックされました。",id)
  fav(status)	
end

#"Let's fly now"したら"Let's try now"する
def rimfire(username,status,id)
 reply("#{"@" + username} Let's try now#{"！" * rand(1..10)}",id)
 fav(status)
end

#今日のロデオ
def rodeo(username,status,id)	
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

#ん？今	
def nandemo(username,status,id)
  reply("#{"@" + username} ん？今なんでもするって言ったよね？#{"\u00A0"*rand(5)}",id)
  fav(status)        
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
  name = contents.gsub(/\(@kasumikobot\)/,"")
  if name.length > 20 then
   name = name[0,20]
   @client.update_profile(name: "#{name}")
   reply("#{"@" + username} 今から俺の名前は#{name}だ！",id)
   @myname = name
  elsif name.length == 1 then
   reply("#{"@" + username} 短すぎるよぉ…",id)
  else
   @client.update_profile(name: "#{name}")
   reply("#{"@" + username} 今から俺の名前は#{name}だ！",id)
   @myname = name
  end
  fav(status)
end	

#ふぁぼれよ
def favre(status)
  fav(status)
end
	
#"現在の名前"に反応して、"はい"とリプライを返す
def answer(status,username,id)
  reply("#{"@" + username} はい#{"\u00A0"*rand(10)}",id)
  fav(status)	
end

#人の顔が見たい
def fx(username,id,status)
  @client.update_with_media("#{"@" + username}", open(File.expand_path("../pic#{rand(1..2)}.png",__FILE__)), :in_reply_to_status_id => id)
  fav(status)
end

#あいさつ
def morn(username,name,id,status)
  morn = ["おっはよ〜", "おはよー", "おはようございます", "おはよう", "おはよーございまーす", "おはよ〜"]
  reply("@" + username + " " + morn.sample+"！ " + name + "さん！",id)
  fav(status)
end

def night(username,name,id,status)
  morn = ["おやすみ〜", "おやすみ", "おやすみなさい", "おやすみです", "今日はもう寝るんですか？", "また明日"]
  reply("@" + username + " " + morn.sample+"！ " + name + "さん！",id)
  fav(status)
end

#突然の死
def suddenly(contents,username,id)
  moji = contents.gsub(/@kasumikobot|　|suddenly|\s/,"")
  n = moji.chomp.bytesize
  w = n/2
  reply("#{"@" + username } \n＿#{"人"*w}＿\n＞　#{moji}　＜\n￣#{"Y^"*w}￣\n",id)
end

#燃やす
def lmf(contents,username,id,status)
  moji = contents.gsub(/@kasumikobot|　|Light my fire|\s|LMF/,"")
  w = moji.chomp.length
  reply("#{"@" + username } \n🔥#{"🔥"*w}🔥\n🔥#{moji}🔥\n🔥#{"🔥"*w}🔥\n",id)
end

#"What time"に反応して現在の時刻(JST)を返す
def whattime(contents,username,id,status)
  clo = Time.now
  reply("#{"@" + username } " + clo.to_s ,id)	
end

#"Where am I"に反応してUserのlocationを返す
def wherei(contents,username,locate,id)
  reply("#{"@" + username } " + locate ,id)
 end

#"Who am I"に反応してUserのnameを返す
def whoi(contents,username,name,id)
  reply("#{"@" + username } " + name ,id)
end

#コイントス
def cointoss(contents,username,id)
  coin = rand(1..2)
  case coin
   when 1 then
    reply("#{"@" + username} 表です。 #{"\u00A0"*rand(5)}" ,id)
   when 2 then
    reply("#{"@" + username} 裏です。 #{"\u00A0"*rand(5)}" ,id)
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
def sex(username,id,status)
  arr = ["ｸｽ","ﾌﾟｸ","ｶｲ","ｺｳ","ｸﾂ","ﾍﾟﾝ","ﾃﾝ","ｹﾝ","ﾌﾟﾝ","ｶﾝ","ﾄｳ","ﾃｲ","ｸｽ","ﾃﾝ"]
  reply(arr.sample+" RT @"+username+": "+contents,id)
  fav(status)
end

#ゆれ
def earthquake
 post("ウーッ！ウーッ！ウーッ！ 緊急事態発生！緊急事態発生！ 直ちにちんちんを格納してください！ ウーッ！ウーッ！ウーッ！ 緊急事態発生！緊急事態発生！ 直ちにちんちんを格納してください！ ウーッ！ウーッ！ウーッ！")
end

#今日のペルソナ
def persona(username,id,status)
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
 fav(status)
end

#今日の斬魄刀
def zanpakutou(username,status,id)	
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

=begin
#簡易計算機
def calc(contents,username,status,id)
 if contents =~ /@kasumikobot Ruby/
 code = contents.sub(/@kasumikobot Ruby /,"")
 reply("#{"@" + username} #{code}")
 end
end
=end

