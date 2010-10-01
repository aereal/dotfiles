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
		def notify_ldr
			ret = ''
			open("http://rpc.reader.livedoor.com/notify?user=aereal") do |out|
				ret << out.read
			end
			count = ret.split('|')[1]
			"LDR: #{count}"
		rescue => e
			@logger.error(e)
		end
	end
end

Backtick.start
