# encoding: utf-8
require'pstore'
require'pp'
#追加
def timetable_add(contents,username,id)
  begin
    contents =contents.gsub(/@kasumikobot|ttadd|科目|\s|　/,"").gsub(/教室|曜|限|、|，/,",").tr("１-６","1-6").split(",")
    timetable = PStore.new('timetable.ps')
    timetable.transaction do
      if timetable[username] == nil
        timetable[username] = [[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],]
      end
      i = nil
      case contents[0]
      when "月"
       i = 0
      when "火"
       i = 1
      when "水"
       i = 2
      when "木"
       i = 3
      when "金"
       i = 4
      end
      j = contents[1].to_i
      subject = contents[2]
      if subject.length>8
        subject = subject[0,8]
      else
        until subject.length == 8
          subject += "　"
        end
      end
      timetable[username][i.to_i][j.to_i-1][0] = subject
      timetable[username][i.to_i][j.to_i-1][1] = contents[3]
    end
    reply("@#{username} 科目を登録しました#{"！"*rand(10)}",id)
  rescue
    reply("@#{username} 科目登録に失敗しました",id)
  end
end


def timetable_viewer(contents,username,id)
  contents = contents.gsub(/@kasumikobot 時間割|曜|\s|　/,"")
  case contents[0]
   when "月"
   i = 0
   when "火"
   i = 1
   when "水"
   i = 2
   when "木"
   i = 3
   when "金"
   i = 4
  end
  tt = PStore.new('timetable.ps')
  tt.transaction do
   if tt[username] == nil
    tt[username] = [[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],]
   end
 post = "@#{username}\n#{contents[0]}曜の時間割です。"
 tt[username][i.to_i].each_with_index{|n,j|
  sub = ""
  room = ""
  case n[0]
  when nil
   sub = "空きコマ　　　　"
  else
  sub = n[0]
  end
  case n[1]
  when nil
   room = ""
  else
  room = n[1]
  end
 post += "\n#{j+1}限 #{sub} #{room}"
 }
p post
reply(post,id)
 end
end

def timetable_resetter(contents,username)
  contents = contents.gsub(/@kasumikobot ttreset /,"").split("\s")
  i,j = 0
  case contents[0]
  when /月曜/
   i = 0
  when /火曜/
   i = 1
  when /水曜/
   i = 2
  when /木曜/
   i = 3
  when /金曜/
   i = 4
  when /all/
   i = 5
  end
  case contents[1].to_i
  when 0
   j = nil
  when 1..6
   j = contents[1].to_i
  end
  tt = PStore.new('timetable.ps')
  tt.transaction do
    if i == 5
      tt[username] = [[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],[[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],],]
    elsif j == nil
        tt[username][i] = [[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil],[nil,nil]]
    else
        tt[username][i][j] = [nil,nil]
    end
pp tt[username]
  end
end
