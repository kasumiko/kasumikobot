# encoding: utf-8
require 'twitter'
require 'tweetstream'
require 'pstore'
require './userconf.rb'
require './def.rb'
require './func.rb'
require './attend.rb'
require './gacha.rb'
require './timetable.rb'

@myname = @client.user.name
mes = @myname+ " is active..."
puts mes
post(mes)

Streamclient = TweetStream::Client.new
Streamclient.userstream do |status|

 username = status.user.screen_name
 contents = status.text
 id = status.id
 name = status.user.name	
 locate = status.user.location


# str = username + ":" + contents
# puts str

 unless username == "kasumikobot" or contents =~ /RT/ then
 if !(contents =~ /@[a-zA-Z0-9_]+\s/) or contents =~ /@kasumikobot/
  if contents =~ /((ゆい|唯|ユイ|yui|YUI|ﾕｲ|Yui)(Ogura|ｵｸﾞﾗ|オグラ|ogura|おぐら|OGURA|おぐらちゃん|小倉ちゃん|小倉|ゆい|yui|ﾕｲ|Yui)|(Ogura|ｵｸﾞﾗ|ogura|OGURA|おぐら|小倉|オグラ)(Yui|ﾕｲ|ゆい|唯|ユイ|YUI|yui|ゆいちゃん|唯ちゃん|ﾕｲちゃん|ﾕｲﾁｬﾝ)|台乙|台乙先生|ゆい\(\*-v・\)ゆい|唯ちゃん|おぐゆい|だいおつ|だい\(\*-v・\)おつ)(ガチャ|がちゃ|ｶﾞﾁｬ)|がちゃおぐら/
   ogura(username,status,id)
  elsif contents =~ /(ゆいおぐら).+(連)(ガチャ)/
   nogura(contents,username,status,id)
  elsif contents =~ /もう(ダメ|だめ)だ/
   cheerogura(username,status,id)
  elsif contents =~ /((のなか|あい|野中|藍)(のなか|あい|野中|藍)|あいぽん|アイポン|ｱｲﾎﾟﾝ)(ガチャ|がちゃ|ｶﾞﾁｬ)/
   aipon(username,status,id)
  elsif contents =~ /(出席|欠席)(ガチャ|がちゃ)/
   attend(username,status,id,name)
  elsif contents =~ /(かすかたん|こまき|かすか|駒木悠平|コマキ|かすみこ)(ガチャ|がちゃ|ｶﾞﾁｬ)/
   kaska(username,status,id)
  elsif contents =~ /(土橋|どばし|ゆめひかり|土橋輝|ドバシ)(ガチャ|がちゃ|ｶﾞﾁｬ)/
   yumehikari(username,status,id)
  elsif contents =~ /今日のアルカナ/
   arcana(username,status,id,name)
  elsif contents =~ /ぬるぽ|ヌルポ|ﾇﾙﾎﾟ/
   nurupo(username,status,id)
  elsif contents =~ /ラーメン食べたい/
   ramen(username,status,id,name)
  elsif contents =~ /ゆーきブロックガチャ/
   yuki(username,status,id)
  elsif contents =~ /うっぱスパムしよ/
   uppa(username,status,id)
  elsif contents =~ /今日の(ロデオ|ろでお|RODEO|rodeo|granrodeo|GRANRODEO|グランロデオ|ｸﾞﾗﾝﾛﾃﾞｵ|GR|グラロデ|ぐらろで|ｸﾞﾗﾛﾃﾞ|KISHOW|kishow|e-ZUKA|e-zuka|val|VAL|たきた|瀧田)/
   rodeo(username,status,id)
  elsif contents =~ /(何|なん)でもする|(なん|何)でもします/
   nandemo(username,status,id)
  elsif contents =~ /\(@kasumikobot\)/
   namechange(contents,username,status,id)
  elsif contents =~ /の顔が(見|み)たいよ/
   fx(username,id,status)
  elsif contents =~ /let's fly now/i
   rimfire(username,status,id)
  elsif contents =~ /ハッピークレセント|ハピクレ/	
   happy(username,status,id)
  elsif contents =~ /おはよ|起きた/
   morn(username,name,id,status)
  elsif contents =~ /寝る|おやすみ/
   night(username,name,id,status)
  elsif contents =~ /ペルソナ！|ペルソナッ！|カッ！|ｶｯ!|ﾍﾟﾙｿﾅ!|ﾍﾟﾙｿﾅｯ!/
     persona(username,id,status)
  elsif contents =~ /今日の斬魄刀/
   zanpakutou(username,status,id)
  elsif contents =~ /ゆれ/
   earthquake  
  elsif contents =~ /ｾｯ/
  sex(username,id,status)
  elsif contents =~ /ふぁぼれよ/
  favre(status)
  elsif contents =~ /(かすかたん|かすみこ)bot|#{@myname}/
  answer(status,username,id)
  end
#  yuyu(contents,username,status,id)  
#  raise(contents,username,status,id)
#  yo
#  calc(contents,username,status,id)
  if /@kasumikobot/.match(status.text) #自分へのメンションであれば 
   if contents =~ /ゆいおぐらカウンタ/
    yuicounter(username,status,id)
   elsif contents =~ /ゆいおぐら(ランク|らんく)|ゆいおぐ(らんく|ランク)/
    ranker(username,status,id)
   elsif contents =~ /.曜.限../
    school_attend(contents,username,id,status)
   elsif contents =~ /出席管理/
    attend_checker(contents,username,status,id)
   elsif contents =~ /suddenly/
    suddenly(contents,username,id,status)
   elsif contents =~ /Light my fire|LMF/i
    lmf(contents,username,id,status)
   elsif contents =~ /what time/i
    whattime(contents,username,id,status)
   elsif contents =~ /Where am I/i
    wherei(contents,username,locate,id)
   elsif contents =~ /who am I/i
    whoi(contents,username,name,id)
   elsif contents =~ /コイントス/
    cointoss(contents,username,id)
   elsif contents =~ /ttadd/
   timetable_add(contents,username,id)
   elsif contents =~ /時間割 .曜/
   timetable_viewer(contents,username,id)
   else
   reply("@#{username + [" それな"," わかる"," せやな"," なるほど"].sample}",id)
   end 
  fav(status)
   
#   diceroll(contents,username,id)
#   writer(contents,username,id)
#   pi(contents,username,id)
  end
 
end
end
end
