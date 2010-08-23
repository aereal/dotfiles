#!/usr/bin/env ruby

require "logger"

log = Logger.new(File.expand_path('~/.skype-notify.log'))
log.level = Logger::INFO
log.progname = 'skype-notify.rb'
icon_path = '/usr/share/icons/skype.png'

def notify(summary, body='')
	system("notify-send -i #{icon_path} '#{summary}' '#{body}'")
end

begin
	type, sname, fname, fpath, smessage, fsize, sskype = *ARGV.dup
	log.debug(ARGV.dup.inspect)

	case type
	when "CallRingingIn"
		notify "Calling!", sname
	when "ContactOnline"
		notify "Login: #{sname}"
	when "ContactOffline"
		notify "Logout: #{sname}"
	when "ContactAuthRequest"
		notify 'Incoming Contact Request', sname
	when "ChatIncomingInitial"
		notify "#{sname} started chat", smessage
	when "TransferRequest"
		notify "Transfer Request from #{sname}", "#{fname}, [#{fsize}KB]"
	when "TransferComplete"
		notify "Transfer Completed!", "#{fname}, [#{fsize}KB]"
	when "Birthday"
		notify "Happy Birthday! #{sname}"
	end
rescue Exception => e
	log.error(e.inspect)
end

