# encoding: utf-8
require 'twitter'
require 'tweetstream'
require './userconf.rb'



now = Time.now
deadline1 = Time.mktime(2014,7,22,12,15,0)
deadline2 = Time.mktime(2014,8,15,12,15,0)
hoge = 0

def deadliner (deadline,now)
hoge = (deadline - now)
  day = hoge/(24*60*60)
  hour = (hoge-(day.to_i*24*60*60))/(60*60)
  min = (hoge-day.to_i*24*60*60-hour.to_i*60*60)/60
 if day>0
  @client.update("応用理工学実験レポートの締め切りまであと#{day.to_int}日#{hour.to_int}時間#{min.to_int}分です.")
 end
 if day==0
  if hour>0
   @client.update("応用理工学実験レポートの締め切りまであと#{hour.to_int}時間#{min.to_int}分です．")
  end
  if hour==0
   @client.update("応用理工学実験レポートの締め切りまであと#{min.to_int}分です．")
  end
 end
end

deadliner(deadline1,now)
