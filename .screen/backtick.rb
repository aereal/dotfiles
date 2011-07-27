#!/usr/bin/env ruby

require "logger"
require "open-uri"

class Backtick
	def self.start
		@@instance ||= self.new
		@@instance.run
	end

	def initialize
		$stdout.sync = true
		@logger = Logger.new(File.expand_path('~/.screen/backtick.log'), 'daily')
		@logger.level = Logger::DEBUG
		@reload_flag = '/tmp/backtick-flag'
	end

	def run
		loop do
			reload if File.exist? @reload_flag
			results = []
			Functions.private_instance_methods.each do |action|
				ret = Functions.send(action)
				@logger.debug("#{action} => #{ret}")
				results << ret
			end
			@logger.debug("result => #{results.inspect}")
			puts results.map {|i| "[#{i}]" }.join(' ')
			sleep 60
		end
	end

	def reload
		File.delete @reload_flag
		load $0
	end

	module Functions
		module_function
		def notify_battery_status
			if `uname`.strip.downcase == 'darwin'
				status = `pmset -g ps`.strip
				source = status[/'(\w+) Power'/, 1]
				charging = status[/(charged|discharging);/, 1]
				capacity = status[/(\d+%)/, 1]
				"#{source}: #{capacity} (#{charging})"
			else
				''
			end
		rescue => e
			@logger.error(e)
		end
	end
end

Backtick.start
