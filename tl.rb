# encoding: utf-8
require 'rubygems'
require 'twitter'
require 'tweetstream'

API_KEY = "rAm3o82TQj1sAEG1DUbeoT668"
API_SECRET = "3rNew1xhd9J3iq4slhtopFAFhImjMv8eKwNH1qrETbyqokjgFW"
ACCESS_TOKEN = "1617849072-eY4gFy0Awq0Z7atIQFNSabqtiRTufFuuyrnKs0W"
ACCESS_TOKEN_SECRET =  "TVFAvEJds2KdF7hFp3XbFmLgknG5020xPcMXByNE59iQi"

TweetStream.configure do |config|
	config.consumer_key = API_KEY
	config.consumer_secret = API_SECRET
	config.oauth_token = ACCESS_TOKEN
	config.oauth_token_secret = ACCESS_TOKEN_SECRET
	config.auth_method = :oauth
end

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = API_KEY
  config.consumer_secret     = API_SECRET
  config.access_token        = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end
myname = @client.user.name


mes = myname+ " is active..."
puts mes
@client.update(mes)

streamclient = TweetStream::Client.new
streamclient.userstream do |status|
username = status.user.screen_name
contents = status.text
id = status.id
name = status.user.name	
locate = status.user.location
	    
#sstr = username + ":" + contents 
#puts str
unless username == "kasumikobot" then
	
	#ハッピークレセント
	if contents =~ /ハッピークレセント|ハピクレ/
	@client.favorite(status)	
	@client.update("#{"@" + username} 永遠ロマンス！#{"\u00A0"*rand(20)}", :in_reply_to_status_id => id)	
 	end

	#ゆゆ式は神アニメ
	if contents =~ /ゆゆ式/
	@client.favorite(status)
	@client.update("#{"@" + username} ゆゆ式は神アニメ "+"\u00A0"*rand(20), :in_reply_to_status_id => id)
	end

	#ゆいおぐらガチャ(通常)
	if contents =~ /((ゆい|唯|ユイ|yui|YUI|ﾕｲ|Yui)(Ogura|ｵｸﾞﾗ|オグラ|ogura|おぐら|OGURA|おぐらちゃん|小倉ちゃん|小倉|ゆ	い|yui|ﾕｲ|Yui)|(Ogura|ｵｸﾞﾗ|ogura|OGURA|おぐら|小倉|オグラ)(Yui|ﾕｲ|ゆい|唯|ユイ|YUI|yui|ゆいちゃん|唯ちゃん|ﾕｲちゃん|ﾕｲﾁｬﾝ)|	台乙|台乙先生|ゆい\(\*-v・\)ゆい|唯ちゃん|おぐゆい|だいおつ|だい\(\*-v・\)おつ)(ガチャ|がちゃ|ｶﾞﾁｬ)|がちゃおぐら|EXcmd/
	count = 0
	fp = open(File.expand_path('../list.txt',__FILE__))
		while fp.gets
		count += 1
		end
		open(File.expand_path('../list.txt',__FILE__)) do |f|
	@client.favorite(status)	
	@client.update("#{"@" + username} " + f.readlines[rand(count)], :in_reply_to_status_id => id)
		end 
	end

	#ゆいおぐらガチャ(応援)
	if contents =~ /もう(ダメ|だめ)だ/
	count = 0
	fp = open(File.expand_path('../list.txt',__FILE__))
	while fp.gets
	count += 1
	end
	open(File.expand_path('../list.txt',__FILE__)) do |f|
	@client.favorite(status)
	@client.update("#{"@" + username} がんばって！\n" + f.readlines[rand(count)], :in_reply_to_status_id => id)
		end   
	end 

	#ゆいおぐらガチャ(n連)
	if contents =~ /(ゆいおぐら).+(連)(ガチャ)/
	count = 0
	fp = open(File.expand_path('../list.txt',__FILE__))
	while fp.gets
	count += 1
	end
	@client.favorite(status)
	name = contents.gsub(/ゆいおぐら/,"").gsub(/連ガチャ/,"")
	n=name.to_i
		if n < 21 then
		n.times do
		open(File.expand_path('../list.txt',__FILE__)) do |f|
		@client.update("#{"@" + username} " + f.readlines[rand(count)], :in_reply_to_status_id => id)
		end
		end
		
		else
		@client.update("#{"@" + username} そんなにいっぱい出せないよぅ…", :in_reply_to_status_id => id)
		end
	end

	#出席ガチャ
	if contents =~ /(出席|欠席)(ガチャ|がちゃ)/
	pro = rand(1..100)
	@client.favorite(status)
		case pro
		when 1..4 then
		 @client.update("#{"@" + username}\n  #{name+"は留年です！\n来年も頑張りましょう！"}", :in_reply_to_status_id => id)

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

		 @client.update("#{"@" + username}\n  #{name+"の今日の出席"} " + ans.to_s + "です。\n今日も一日がんばりましょう！", :in_reply_to_status_id => id)
		end
	end

	#"かすかたんガチャ"に反応して怒る
	if contents =~ /かすかたんガチャ/
	@client.favorite(status)
	@client.update("#{"@" + username} うっせーばーか#{"！" * rand(1..10)}", :in_reply_to_status_id => id)
	end

	#土橋ガチャ
	if contents =~ /(土橋|どばし|ゆめひかり|土橋輝)(ガチャ|がちゃ|ｶﾞﾁｬ)/
	count = 0
	fp = open(File.expand_path('../dobashi.txt',__FILE__))
	while fp.gets
	count += 1
	end
	open(File.expand_path('../dobashi.txt',__FILE__)) do |f|
	@client.favorite(status)
	@client.update("#{"@" + username} " + f.readlines[rand(count)], :in_reply_to_status_id => id)
	end 
	end

	#今日のアルカナ
	if contents =~ /今日のアルカナ/
	arcana = ["愚者-The FOOL-", "魔術師-The MAGICIAN-", "女教皇-The HIGHPRIESTESS-", "女帝-The EMPRESS-", "皇帝-The EMPEROR-", "法王-The HIEROPHANT-", "恋愛-The LOVERS-", "戦車-The CHARIOT-", "正義-The JUSTICE-", "隠者-The HERMIT-", "運命-The WHEEL OF FORTUNE-", "剛毅-The STRENGTH-", "刑死者-The HANGEDMAN-", "死神-The DEATH-", "節制-The TEMPERANCE-", "悪魔-The DEVIL-", "塔-The TOWER-", "星-The STAR-", "月-The MOON-", "太陽-The SUN-", "審判-The JUDGEMENT-", "世界-The WORLD-", "永劫-The AEON-", "道化師-The JOKER-", "欲望-The DESIRE-"]
	@client.favorite(status)
	@client.update("#{"@" + username} " + name +"さんのアルカナは #{arcana.sample} です。", :in_reply_to_status_id => id)
	end

	#"たかまり"に反応して、一日ワンチャンアシカﾓﾉﾏﾈチャンスを返す
	if contents =~ /たかまる|ﾀｶﾏﾙ|タカマル|高まる/
	@client.favorite(status)
	@client.update("#{"@" + username} ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ ﾀ゛ｶ゛ﾏ゛ﾙ゛ #一日ワンチャンアシカﾓﾉﾏﾈチャンス", :in_reply_to_status_id => id)
	end
	   
	#ぬるぽがっ
	if contents =~ /ぬるぽ|ヌルポ|ﾇﾙﾎﾟ/
	@client.favorite(status)
	@client.update("#{"@" + username} ｶﾞｯ#{"\u00A0"*rand(5)}", :in_reply_to_status_id => id)
	end
	
	#今日のラーメン
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
		menu =	["極み鶏"]
		
		when 4 then
		ramen = "油虎"
		menu = ["油そば","油そば肉のせ","油そばジャンク盛り","汁なし坦々まぜそば"]
		when 5 then
		ramen = "蒼"
		menu = ["つけ麺","卵かけつけ麺","海老香味ラーメン","汁なしそば"]
	  end
	@client.favorite(status)
    	@client.update("#{"@" + username} 今日" + name + "さんが食べるラーメンは#{ramen + "の" + menu.sample}です。", :in_reply_to_status_id => id)

	end

	#ゆーきがブロックされる
	if contents =~ /ゆーきブロックガチャ/
	@client.update("#{"@" + username} ゆーきくん(@yu_ki_kun_1)は#{rand(1000)}人にブロックされています。", :in_reply_to_status_id => id)
	end

	#うっぱがスパムされる
	if contents =~ /うっぱスパムしよ/
	@client.favorite(status)
	@client.update("#{"@" + username} うっぱは#{rand(1000)}人にブロックされました。", :in_reply_to_status_id => id)
	end
	
	#"Let's fly now"したら"Let's try now"する
	if contents =~ /(Let's|let's) (fly|Fly) (now|Now)/
	@client.favorite(status)
	@client.update("#{"@" + username} Let's try now#{"！" * rand(1..10)}", :in_reply_to_status_id => id)
	end

	#今日のロデオ
	if contents =~ /今日の(ロデオ|ろでお|RODEO|rodeo|granrodeo|GRANRODEO|グランロデオ|ｸﾞﾗﾝﾛﾃﾞｵ|GR|グラロデ|ぐらろで|ｸﾞﾗﾛﾃﾞ|KISHOW|kishow|e-ZUKA|e-zuka|val|VAL|たきた|瀧田)/
	count = 0
	fp = open(File.expand_path('../rodeo.txt',__FILE__))
	while fp.gets
	count += 1
	end
	open(File.expand_path('../rodeo.txt',__FILE__)) do |f|
	@client.favorite(status)
	@client.update("#{"@" + username} 今日あなたにおすすめのGRANRODEOの曲は\n" + f.readlines[rand(count)], :in_reply_to_status_id => id)
	end 
	end
	
	#ん？今	
	if contents =~ /(何|なん)でもする|(なん|何)でもします/
	@client.favorite(status)
	@client.update("#{"@" + username} ん？今なんでもするって言ったよね？#{"\u00A0"*rand(5)}", :in_reply_to_status_id => id)
        end

	#Yo
	if contents =~ /Yo|yo/
	@client.favorite(status)
	@client.update("#{"@" + username} Yo#{"\u00A0"*rand(10)}" ,:in_reply_to_status_id => id)
	end

	#namechange
	if contents =~ /\(@kasumikobot\)/
	@client.favorite(status)
	name = contents.gsub(/\(@kasumikobot\)/,"")
		 if name.length > 20 then
		 name = name[0,20]
		 @client.update_profile(name: "#{name}")
		 @client.update("#{"@" + username} 今から俺の名前は#{name}だ！", :in_reply_to_id => id)
		 elsif name.length == 1 then
		 @client.update("#{"@" + username} 短すぎるよぉ…", :in_reply_to_id => id)
		 else
		 @client.update_profile(name: "#{name}")
		 @client.update("#{"@" + username} 今から俺の名前は#{name}だ！", :in_reply_to_id => id)
		end
	end
	
	#ふぁぼれよ
	if contents =~ /ふぁぼれよ/
	@client.favorite(status)
	end

if /@kasumikobot/.match(status.text) #自分へのメンションであれば

	if contents =~ /suddenly/
	moji = contents.gsub(/@kasumikobot|　|suddenly|\s/,"")
=begin
	u = moji.strip
	p = u.chars.reject(&:ascii_only?)
	n = u.length + p.length/2.round
	w = n
=end
#	w = moji.length
	n = moji.chomp.bytesize
	w = n/2
	@client.favorite(status)
	@client.update("#{"@" + username } \n＿#{"人"*w}＿\n＞#{moji}＜\n￣#{"Y^"*w}￣\n", :in_reply_to_status_id => id)
	end

end

	if contents =~ /Light my fire|LMF/
	moji = contents.gsub(/@kasumikobot|　|Light my fire|\s|LMF/,"")
	w = moji.chomp.length
	@client.favorite(status)
	@client.update("#{"@" + username } \n🔥#{"🔥"*w}🔥\n🔥#{moji}🔥\n🔥#{"🔥"*w}🔥\n", :in_reply_to_status_id => id)
	end

	#"What time"に反応して現在の時刻(JST)を返す
	if contents =~ /(what|What) time/
	clo = Time.now
	@client.favorite(status)
	@client.update("#{"@" + username } " + clo.to_s ,:in_reply_to_status_id => id)
	end
	
	#"Where am I"に反応してUserのlocationを返す
	if contents =~ /(where|Where) am I/
	@client.favorite(status)
	@client.update("#{"@" + username } " + locate ,:in_reply_to_status_id => id)
	end
	
	#"Who am I"に反応してUserのnameを返す
	if contents =~ /(who|Who) am I/
	@client.favorite(status)
	@client.update("#{"@" + username } " + name ,:in_reply_to_status_id => id)
	end

	#"現在の名前"に反応して、"はい"とリプライを返す
	if contents =~ /#{myname}|かすかたんbot/
	@client.favorite(status)
	@client.update("#{"@" + username} はい#{"\u00A0"*rand(10)}", :in_reply_to_id => id)
	end

end
end
