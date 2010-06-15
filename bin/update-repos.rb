#!/usr/bin/env ruby

if $0 == __FILE__
	require "fileutils"
	include FileUtils::Verbose

	HOME = ENV['HOME']
	scm_commands = {
		'.git' => 'git pull',
		'.hg'  => 'hg pull',
	}
	Dir["#{HOME}/projects/*"].reject {|dir|
		dir.end_with? "coderepos"
	}.each do |proj|
		cd proj
		scm_dir = Dir[".*"].find {|i|
			scm_commands.keys.include?(i)
		}
		next unless scm_dir
		system scm_commands[scm_dir]
	end
end

