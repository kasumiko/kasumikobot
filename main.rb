# encoding: utf-8
require 'twitter'
require 'tweetstream'
require 'pstore'
require './userconf.rb'
require './def.rb'
require './func.rb'
require './attend.rb'

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
  happy(contents,username,status,id)
#  yuyu(contents,username,status,id)
  ogura(contents,username,status,id)
  cheerogura(contents,username,status,id)
  nogura(contents,username,status,id)
  attend(contents,username,status,id,name)
  kaska(contents,username,status,id)
  yumehikari(contents,username,status,id)
  arcana(contents,username,status,id,name)
  raise(contents,username,status,id)
  nurupo(contents,username,status,id)
  ramen(contents,username,status,id,name)
  yuki(contents,username,status,id)
  uppa(contents,username,status,id)
  rimfire(contents,username,status,id)
  rodeo(contents,username,status,id)
  answer(contents,status,username,id)
  nandemo(contents,username,status,id)
#  yo
  namechange(contents,username,status,id)
  favre(contents,status)
  fx(contents,username,id,status)
  greet(contents,username,name,id,status) 
  aipon(contents,username,status,id)
  sex(contents,username,id,status)
  earthquake(contents,username,status)
  persona(contents,username,id)
  zanpakutou(contents,username,status,id)
#  calc(contents,username,status,id)


  if /@kasumikobot/.match(status.text) #自分へのメンションであれば
   suddenly(contents,username,id,status)
   lmf(contents,username,id,status)
   whattime(contents,username,id,status)
   wherei(contents,username,locate,id)
   whoi(contents,username,name,id)
   fav(status)
   cointoss(contents,username,id)
#   diceroll(contents,username,id)
#   writer(contents,username,id)
#   pi(contents,username,id)
   yuicounter(contents,username,status,id)
   ranker(contents,username,status,id)
   school_attend(contents,username,id,status)
   attend_checker(contents,username,status,id)
  end
 
 end
end
end