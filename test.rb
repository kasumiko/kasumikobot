# encoding: utf-8
contents = "test"
  puts contents
open(File.expand_path('../test1.txt',__FILE__),'w') do |f|
   f.write contents
  end 
