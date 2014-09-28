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
  case contents
  when /((ゆい|唯|ユイ|yui|YUI|ﾕｲ|Yui)(Ogura|ｵｸﾞﾗ|オグラ|ogura|おぐら|OGURA|おぐらちゃん|小倉ちゃん|小倉|ゆい|yui|ﾕｲ|Yui)|(Ogura|ｵｸﾞﾗ|ogura|OGURA|おぐら|小倉|オグラ)(Yui|ﾕｲ|ゆい|唯|ユイ|YUI|yui|ゆいちゃん|唯ちゃん|ﾕｲちゃん|ﾕｲﾁｬﾝ)|台乙|台乙先生|ゆい\(\*-v・\)ゆい|唯ちゃん|おぐゆい|だいおつ|だい\(\*-v・\)おつ)(ガチャ|がちゃ|ｶﾞﾁｬ)|がちゃおぐら/
   ogura(username,status,id)
  when /(ゆいおぐら).+(連)(ガチャ)/
   nogura(contents,username,status,id)
  when /もう(ダメ|だめ)だ/
   cheerogura(username,status,id)
  when /((のなか|あい|野中|藍)(のなか|あい|野中|藍)|あいぽん|アイポン|ｱｲﾎﾟﾝ)(ガチャ|がちゃ|ｶﾞﾁｬ)/
   aipon(username,status,id)
  when /(出席|欠席)(ガチャ|がちゃ)/
   attend(username,status,id,name)
  when /(かすかたん|こまき|かすか|駒木悠平|コマキ|かすみこ)(ガチャ|がちゃ|ｶﾞﾁｬ)/
   kaska(username,status,id)
  when /(土橋|どばし|ゆめひかり|土橋輝|ドバシ)(ガチャ|がちゃ|ｶﾞﾁｬ)/
   yumehikari(username,status,id)
  when /今日のアルカナ/
   arcana(username,status,id,name)
  when /ぬるぽ|ヌルポ|ﾇﾙﾎﾟ/
   nurupo(username,status,id)
  when /ラーメン食べたい/
   ramen(username,status,id,name)
  when /ゆーきブロックガチャ/
   yuki(username,status,id)
  when /うっぱスパムしよ/
   uppa(username,status,id)
  when /今日の(ロデオ|ろでお|RODEO|rodeo|granrodeo|GRANRODEO|グランロデオ|ｸﾞﾗﾝﾛﾃﾞｵ|GR|グラロデ|ぐらろで|ｸﾞﾗﾛﾃﾞ|KISHOW|kishow|e-ZUKA|e-zuka|val|VAL|たきた|瀧田)/
   rodeo(username,status,id)
  when /(何|なん)でもする|(なん|何)でもします/
   nandemo(username,status,id)
#  when /\(@kasumikobot\)/
#   namechange(contents,username,status,id)
  when /の顔が(見|み)たいよ/
   fx(username,id,status)
  when /let's fly now/i
   rimfire(username,status,id)
  when /ハッピークレセント|ハピクレ/	
   happy(username,status,id)
  when /おはよ|起きた/
   morn(username,name,id,status)
  when /寝る|おやすみ/
   night(username,name,id,status)
  when /ペルソナ！|ペルソナッ！|カッ！|ｶｯ!|ﾍﾟﾙｿﾅ!|ﾍﾟﾙｿﾅｯ!/
     persona(username,id,status)
  when /今日の斬魄刀/
   zanpakutou(username,status,id)
  when /ゆれ/
   earthquake  
  when /ｾｯ/
  sex(username,id,status)
  when /ふぁぼれよ/
  favre(status)
  when /(かすかたん|かすみこ)bot|#{@myname}/
  answer(status,username,id)
#  yuyu(contents,username,status,id)  
#  raise(contents,username,status,id)
#  yo
#  calc(contents,username,status,id)
  when /@kasumikobot/ #自分へのメンションであれば 
   case contents
   when /ゆいおぐらカウンタ/
    yuicounter(username,id)
   when /ゆいおぐら(ランク|らんく)|ゆいおぐ(らんく|ランク)/
    ranker(username,id)
   when /ttadd/
    timetable_add(contents,username,id)   
   when /.曜.限../
    school_attend(contents,username,id)
   when /出席管理/
    attend_checker(contents,username,id)
   when /ttreset/
　　　　timetable_resetter(contents,username)
   when /suddenly/
    suddenly(contents,username,id)
   when /Light my fire|LMF/i
    lmf(contents,username,id)
   when /what time/i
    whattime(contents,username,id)
   when /Where am I/i
    wherei(contents,username,locate,id)
   when /who am I/i
    whoi(contents,username,name,id)
   when /コイントス/
    cointoss(contents,username,id)
   when /時間割 .曜/
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
