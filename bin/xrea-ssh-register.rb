#!/usr/bin/env ruby

require 'optparse'
require 'open-uri'
require 'pathname'

def passwd(user)
	accounts = Pathname.new('~/.xrea-accounts').expand_path.read.split("\n").map {|i|
		i.split(":")
	}
	accounts = Hash[*accounts.flatten]
	accounts[user]
end

if $0 == __FILE__
	@user, @host = *ARGV
	@pass = passwd(@user)

	open("http://www.#{@host}/jp/admin.xcg?id=#{@user}&pass=#{@pass}&telnet=t") do |f|
		data = f.read
		ip = data[/NAME="remote_host" VALUE="([\d.]+)"/, 1]
		raise "can't get IP" unless ip
		open("http://www.#{@host}/jp/admin.xcg?id=#{@user}&pass=#{@pass}&remote_host=#{ip}&ssh2=SSH%93o%98%5E") {}
	end
end

