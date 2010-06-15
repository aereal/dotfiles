#!/usr/bin/env ruby

SKYPE_ICON = "/home/aereal/skype.png"

class String
	def quote
		'"' + self + '"'
	end
end

def notify(caption, body = nil)
	system("notify-send -i #{SKYPE_ICON.quote} #{caption.quote} #{(body || "").quote}")
end

@type, @sname, @fname, @fpath, @smessage, @fsize, @sskype = *ARGV.dup

case @type
when "SkypeLogin"
	notify "Login (#{@sskype})"
when "SkypeLogout"
when "SkypeLoginFailed"
	notify "Failed Login (#{@sskype})"
when "CallConnecting"
when "CallRingingIn"
	notify "Call from #{@sname}"
when "CallRingingOut"
when "CallAnswered"
when "CallBusy"
when "CallFailed"
when "CallMissed"
when "CallHold"
when "CallResume"
when "CallHangup"
when "CallRemoteHangup"
when "VoicemailReceived"
when "VoicemailSent"
when "ContactOnline"
	notify "ONLINE", @sname.quote
when "ContactOffline"
when "ContactAuthRequest"
	notify "Request (add to contact list)", "from #{@sname}"
when "ContactAdded"
when "ContactDeleted"
when "ChatIncomingInitial"
	notify "#{@sname} has started chat"
when "ChatIncoming"
	notify "New message from #{@sname}", @smessage.quote
when "ChatOutgoing"
when "ChatJoined"
	notify "#{@sname} has joined"
when "ChatParted"
	notify "#{@sname} has left"
when "TransferRequest"
	notify "Download from #{@sname}", @fname.quote
when "TransferComplete"
	notify "Completed! (Download from #{@sname})", @fname.quote
when "TransferFailed"
	notify "Failed (Download from #{@sname})", @fname.quote
when "SMSSent"
when "SMSFailed"
when "Birthday"
end

