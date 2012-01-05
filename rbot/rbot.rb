#!/usr/bin/ruby1.9.1
require 'cinch'
require '../libs/ktime.rb'

oplist = ['0::ffff:74.248.215.158','0::ffff:127.0.0.1','adsl-74-248-215-158.tys.bellsouth.net','74.208.67.72','c-69-249-96-237.hsd1.pa.comcast.net','adsl-108-194-110-194.dsl.rcsntx.sbcglobal.net','98.65.197.33','xp'];
hoplist = ['articbreeze.net','adsl-108-194-110-194.dsl.rcsntx.sbcglobal.net','xp']
chaway = "01"
awaymsg = "Kite is active"
bot = Cinch::Bot.new do
	configure do |c|
		c.server = ARGV[0]
		c.nick = "Keldor"
		c.user = "rbot"
		c.realname = "Kite's Rbot(Ruby IRC Bot)"
		c.channels = ["#spam","#dothack"]
	end
	on :message, "hello" do |m,msg|
		m.reply "Nick: #{m.user.nick}"
		m.reply "User: #{m.user}"
		m.reply "Host: #{m.user.host}"	
	end
	on :message, /^!oplist$/ do |m|
		m.reply "Current Ops are:"
		m.reply "Kiten, Keldor(Kite Bot), DHowett, Sbinger, Mutex, Sercus(Mutex Bot) ..."
		m.reply "Oligos(DHowett Bot)"
	end
	on :message, /^!hoplist$/ do |m|
		m.reply "MikeBeas, Salax"
	end
	on :message, /^!op (.+)$/ do |m,n|
		 if oplist.include?(m.user.host)
		    if n == '.'
			bot.raw("MODE "+m.channel+" +o #{m.user.nick}")
		   else
		    	bot.raw("MODE "+m.channel+" +o "+n)
		   end
		end
	end
	on :message, /^!dop (.*)$/ do |m,n|
		  if oplist.include?(m.user.host)
			if n == '.'
				bot.raw("MODE "+m.channel+" -o #{m.user.nick}")
			else
				bot.raw("MODE "+m.channel+" -o "+n)
			end
		end
	end
	on :message, /^!hop (.+)$/ do |m,n|
		if hoplist.include?(m.user.host)
		bot.raw("MODE "+m.channel+" +h "+n)
		end
		if oplist.include?(m.user.host)
		bot.raw("MODE "+m.channel+" +h "+n)
		end
	end
	on :message, /^!dhop (.+)$/ do |m,n|
	  	if oplist.include?(m.user.host)
		bot.raw("MODE "+m.channel+" -h "+n)
		end
		if hoplist.include?(m.user.host)
		bot.raw("MODE "+m.channel+" -h "+n)
		end
   	end
	on :message, "!help" do |m|
		m.reply "[!op,!dop] [!hop, !dhop] [!help] [!log, !status] [!join, !leave] [!raw, !say]"
	end
	on :message, /^!nick (.+)$/ do |m,n|
		tmp = n
		if oplist.include?(m.user.host)
		bot.raw("NICK "+tmp)
		end
	end
	on :message, /^!log (.+)$/ do |m,msg|
		m.reply "message written!"
		tmp = msg
		File.open("Ruby.log","a") do |rlog|
		rltime = tflog
		rlog << rltime+" "+msg+" by: "+m.user.nick+"\n"
		rlog.close
		end
	end
	on :message, /^!join (.+)$/ do |m,chan|
		if oplist.include?(m.user.host)
			bot.raw("JOIN "+chan)
		end
	end
	on :message, /^!leave (.+)$/ do |m,chan|
		if oplist.include?(m.user.host)
			bot.raw("PART "+chan)
		end
	end
	on :message, /^!server (.+)$/ do |m,serv|
		bot.raw("SERVER "+serv)
	end
	on :message, /^!addop (.+)$/ do |m,sx|
		File.open("oplist.crypt","w") do |fh|
		fh << Users.user(sx).host
		end
	end
	on :message, /^!raw (.+)$/ do |m,msg|
		      if oplist.include?(m.user.host)
				bot.raw(msg)
			end
	end
	on :message, /^!say (.+)$/ do |m,msg|
		m.reply(msg,false)
	end
	on :message, /^!sleep$/ do |m,msg|
		if m.user.nick == "Kite"
			if chaway == "01"
				chaway = "02"
				awaymsg = "Kite is away"
				m.reply(awaymsg,false)
			elsif chaway == "02"
				chaway = "01"
				awaymsg = "Kite is active"
				m.reply(awaymsg,false)
			else
				m.reply("Something Broke", false)
			end
		end
 	 end
	on :message, /^!status$/ do |m|
		m.reply(awaymsg,false)
	end

	on :message, /^!est$/ do |m|
		m.reply(Time.now)
	end
end
bot.start
