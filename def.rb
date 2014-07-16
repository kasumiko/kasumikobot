# encoding: utf-8
def react

#ハピクレ
if contents =~ /ハッピークレセント|ハピクレ/
@client.update("#{"@" + username} 永遠ロマンス#{"！" * rand(1..10)}", :in_reply_to_status_id => id)
end
=begin
#ゆいおぐらガチャ(通常)
if contents =~ /((ゆい|唯|ユイ|yui|YUI|ﾕｲ|Yui)(Ogura|ｵｸﾞﾗ|オグラ|ogura|おぐら|OGURA|おぐらちゃん|小倉ちゃん|小倉|ゆい|yui|ﾕｲ|Yui)|(Ogura|ｵｸﾞﾗ|ogura|OGURA|おぐら|小倉|オグラ)(Yui|ﾕｲ|ゆい|唯|ユイ|YUI|yui|ゆいちゃん|唯ちゃん|ﾕｲちゃん|ﾕｲﾁｬﾝ)|台乙|台乙先生|ゆい\(\*-v・\)ゆい|唯ちゃん|おぐゆい|だいおつ|だい\(\*-v・\)おつ)(ガチャ|がちゃ|ｶﾞﾁｬ)|がちゃおぐら|EXcmd/
#count = 0
#fp = open(File.expand_path('../list.txt',__FILE__))
#while fp.gets
#count += 1
#end
#open(File.expand_path('../list.txt',__FILE__)) do |f|
@client.update("#{"@"+username+" てすと"}", :in_reply_to_status_id => id)
end 
#f.readlines[rand(count)]
=end
end
