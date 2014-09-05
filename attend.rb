# encoding: utf-8
require'pstore'
require'pp'
#出席管理
def school_attend(contents,username,id,status)
contents = contents.gsub(/@kasumikobot|\s|　/,"").tr('１-９','1-9')
 attend = PStore.new('attend.ps')
 attend.transaction do
  if attend[username] == nil
   attend[username]=[[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],]
  end
  i,j,k = nil
  case contents[0,2]
  when "月曜"
  i = 0
  when "火曜"
  i = 1
  when "水曜"
  i = 2
  when "木曜"
  i = 3
  when "金曜"
  i = 4
  end
  case contents[2,2]
  when "1限"
  j = 0
  when "2限"
  j = 1
  when "3限"
  j = 2
  when "4限"
  j = 3
  when "5限"
  j = 4
  when "6限"
  j = 5
  end
  case contents[4,2]
  when "出席"
  k = 0
  when "欠席"
  k = 1
  when "休講"
  k = 2
  end
 attend[username][i][j][k] += 1
 end
end
#見る
def attend_checker(contents,username,status,id)
 attend = PStore.new('attend.ps')
 attend.transaction do
  if attend[username] == nil
   attend[username]=[[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],],]

  end
contents = contents.gsub(/@kasumikobot 出席管理|\s|　/,"")
  case contents[0,2]
  when "月曜"
  i = 0
  when "火曜"
  i = 1
  when "水曜"
  i = 2
  when "木曜"
  i = 3
  when "金曜"
  i = 4
  end
cont = "#{"@"+username} あなたの#{contents[0,2]}の出席情報です。\n1限 #{attend[username][i][0][0]}出席 #{attend[username][i][0][1]}欠席 #{attend[username][i][0][2]}休講\n2限 #{attend[username][i][1][0]}出席 #{attend[username][i][1][1]}欠席 #{attend[username][i][1][2]}休講\n3限 #{attend[username][i][2][0]}出席 #{attend[username][i][2][1]}欠席 #{attend[username][i][2][2]}休講\n4限 #{attend[username][i][3][0]}出席 #{attend[username][i][3][1]}欠席 #{attend[username][i][3][2]}休講\n5限 #{attend[username][i][4][0]}出席 #{attend[username][i][4][1]}欠席 #{attend[username][i][4][2]}休講\n6限 #{attend[username][i][5][0]}出席 #{attend[username][i][5][1]}欠席 #{attend[username][i][5][2]}休講\n"
reply(cont,id)
 end
end
