require 'rubygems'
require 'rake'

module Enumerable
	def like?(val, op=:===)
		any? do |i|
			i.__send__(op, val)
		end
	end
end

class String
	def expand
		File.expand_path(self)
	end

	def exist?
		File.exist?(self.expand)
	end
end

HOME          = '~'.expand
SOURCE_DIR    = '~/dotfiles'.expand
TARGET_DIR    = HOME

cd SOURCE_DIR
EXCLUDE_FILES = [/\.$/, '.git', '.svn']
DOTFILES   = FileList['.*'].reject do |f|
	EXCLUDE_FILES.like?(f)
end

directory SOURCE_DIR
directory TARGET_DIR

task :default do
	if '.git'.exist?
		sh 'git pull'
	else
		sh 'git clone git@github.com:aereal/dotfiles.git .'
	end
end

desc "Installing dotfiles in your home directory"
task :install do
	DOTFILES.each do |f|
		ln_sf f, "#{TARGET_DIR}/#{f}"
	end
end

desc "Remove dotfiles and symbolic link"
task :uninstall do
	DOTFILES.each do |f|
		rm "#{TARGET_DIR}/#{f}"
	end
end

