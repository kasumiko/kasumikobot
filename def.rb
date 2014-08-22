# encoding: utf-8
#Tweetする
def post(post,option={})
@client.update(post,option={})
end

#replyする
def reply(post,id)
@client.update(post,:in_reply_to_status_id => id)
end

#favる
def fav(status)
@client.favorite(status)
end


