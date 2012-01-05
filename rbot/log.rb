#!/usr/bin/ruby
require '/work/ruby/libs/ktime.rb'
if File.exists?(ARGV[0]) == true
	File.open(ARGV[0],"a") do |log|
		ftime = tflog
		log << ftime+" "+ARGV[1]+"\n"
		log.close
	end
end
if File.exists?(ARGV[0]) == false
	File.open(ARGV[0],"w") do |log|
		ftime = tflog
		log << ftime+" "+ARGV[1]+"\n"
		log.close
		end
end
