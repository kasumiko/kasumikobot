# encoding: utf-8
require 'twitter'
require 'tweetstream'
require './userconf.rb'
require './def.rb'
require './postdata.rb'
require 'yaml'

myname = @client.user.name
mes = myname+ " is active..."
puts mes
post(mes)

Streamclient = TweetStream::Client.new
Streamclient.userstream do |status|

 username = status.user.screen_name
 contents = status.text
 id = status.id
 name = status.user.name	
 locate = status.user.location
 myname = @client.user.name

# str = username + ":" + contents
# puts str

 unless username == "kasumikobot" or contents =~ /RT/ then

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
  nandemo(contents,username,status,id)
  #yo
  namechange(contents,username,status,id)
  favre(contents,status)
  answer(contents,status,username,myname,id)
  fx(contents,username,id,status)
  greet(contents,username,name,id,status) 
  aipon(contents,username,status,id)

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
  end

 end
end
