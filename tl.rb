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

puts "Configuration Success"

streamclient = TweetStream::Client.new
streamclient.userstream do |status|
	username = status.user.screen_name
	contents = status.text
	id = status.id

str = username + ":" + contents
	puts str
unless username == "kasumikobot" then
	
	#ハッピークレセント
	if contents =~ /ハッピークレセント|ハピクレ/
	@client.update("#{"@" + username} 永遠ロマンス#{"！" * rand(1..10)}", :in_reply_to_status_id => id)
	end

	#ゆゆ式は神アニメ
	if contents =~ /ゆゆ式/
	@client.update("#{"@" + username} ゆゆ式は神アニメ", :in_reply_to_status_id => id)
	end

	#ゆいおぐらガチャ(通常)
	if contents =~ /((ゆい|唯|ユイ|yui|YUI|ﾕｲ|Yui)(Ogura|ｵｸﾞﾗ|オグラ|ogura|おぐら|OGURA|おぐらちゃん|小倉ちゃん|小倉|ゆ	い|yui|ﾕｲ|Yui)|(Ogura|ｵｸﾞﾗ|ogura|OGURA|おぐら|小倉|オグラ)(Yui|ﾕｲ|ゆい|唯|ユイ|YUI|yui|ゆいちゃん|唯ちゃん|ﾕｲちゃん|ﾕｲﾁｬﾝ)|	台乙|台乙先生|ゆい\(\*-v・\)ゆい|唯ちゃん|おぐゆい|だいおつ|だい\(\*-v・\)おつ)(ガチャ|がちゃ|ｶﾞﾁｬ)|がちゃおぐら|EXcmd/
	count = 0
	fp = open(File.expand_path('../list.txt',__FILE__))
		while fp.gets
		count += 1
		end
		open(File.expand_path('../list.txt',__FILE__)) do |f|
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
		case pro
		when 1..4 then
		 @client.update("#{"@" + username}\n  #{"は留年です！\n来年も頑張りましょう！"}", :in_reply_to_status_id => id)

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

		 @client.update("#{"@" + username}\n  #{"の今日の出席"} " + ans.to_s + "です。\n今日も一日がんばりましょう！", :in_reply_to_status_id => id)
		end
	end

	#"かすかたんガチャ"に反応して怒る
	if contents =~ /かすかたんガチャ/
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
	@client.update("#{"@" + username} " + f.readlines[rand(count)], :in_reply_to_status_id => id)
	end 
	end

	#今日のアルカナ
	if contents =~ /今日のアルカナ/
	arcana = ["愚者-The FOOL-", "魔術師-The MAGICIAN-", "女教皇-The HIGHPRIESTESS-", "女帝-The EMPRESS-", "皇帝-The EMPEROR-", "法王-The HIEROPHANT-", "恋愛-The LOVERS-", "戦車-The CHARIOT-", "正義-The JUSTICE-", "隠者-The HERMIT-", "運命-The WHEEL OF FORTUNE-", "剛毅-The STRENGTH-", "刑死者-The HANGEDMAN-", "死神-The DEATH-", "節制-The TEMPERANCE-", "悪魔-The DEVIL-", "塔-The TOWER-", "星-The STAR-", "月-The MOON-", "太陽-The SUN-", "審判-The JUDGEMENT-", "世界-The WORLD-", "永劫-The AEON-", "道化師-The JOKER-", "欲望-The DESIRE-"]
	@client.update("#{"@" + username} " + "" + "さんのアルカナは #{arcana.sample} です。", :in_reply_to_status_id => id)
	end

	#"たかまり"に反応して、一日ワンチャンアシカﾓﾉﾏﾈチャンスを返す
	if contents =~ /たかまる|ﾀｶﾏﾙ|タカマル|高まる/
	@client.update("#{"@" + username} ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ｱ゛ ﾀ゛ｶ゛ﾏ゛ﾙ゛ #一日ワンチャンアシカﾓﾉﾏﾈチャンス", :in_reply_to_status_id => id)
	end
	   
	#ぬるぽがっ
	if contents =~ /ぬるぽ|ヌルポ|ﾇﾙﾎ/
	@client.update("#{"@" + username} ｶﾞｯ#{"　"*rand(5)}", :in_reply_to_status_id => id)
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
    	@client.update("#{"@" + username} 今日" + "" + "さんが食べるラーメンは#{ramen + "の" + menu.sample}です。", :in_reply_to_status_id => id)

	end

	#ゆーきがブロックされる
	if contents =~ /ゆーきブロックガチャ/
	@client.update("#{"@" + username} ゆーきくん(@yu_ki_kun_1)は#{rand(1000)}人にブロックされています。", :in_reply_to_status_id => id)
	end

	#うっぱがスパムされる
	if contents =~ /うっぱスパムしよ/
	@client.update("#{"@" + username} うっぱは#{rand(1000)}人にブロックされました。", :in_reply_to_status_id => id)
	end
	
	#"Let's fly now"したら"Let's try now"する
	if contents =~ /(Let's|let's) (fly|Fly) (now|Now)/
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
	@client.update("#{"@" + username} 今日あなたにおすすめのGRANRODEOの曲は\n" + f.readlines[rand(count)], :in_reply_to_status_id => id)
	end 
	end
	
	#ん？今	
	if contents =~ /(何|なん)でもする|(なん|何)でもします/
	@client.update("#{"@" + username} ん？今なんでもするって言ったよね？", :in_reply_to_status_id => id)
        end

end
end
