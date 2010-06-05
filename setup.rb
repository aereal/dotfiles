#!/usr/bin/env ruby
#
# http://github.com/cho45/dotfiles/raw/master/setup.rb

require "pathname"
require "fileutils"
include FileUtils::Verbose

class String
	def expand
		ret = Pathname.new(self).expand_path
		ret.parent.mkpath unless ret.parent.exist?
		ret
	end
end

def sh(*args)
	puts args.join(' ')
	system(*args)
end

def link(src, dst)
	puts "#{src} =>\n\t#{dst}"
	src = Pathname.new(src).expand_path
	dst = Pathname.new(dst).expand_path
	dst.parent.mkpath unless dst.parent.exist?
	remove_file dst if dst.symlink?
	remove_file dst if dst.file?
	ln_sf src.to_s, dst.to_s
end

cd '~'.expand

if 'dotfiles'.expand.exist?
	cd 'dotfiles'
	sh 'git pull'
else
	sh 'git clone git://github.com/aereal/dotfiles.git dotfiles'
	cd 'dotfiles'
end

'bin'.expand.mkpath

Dir["bin/*"].each do |f|
	link f, '~/bin'
end

Dir["**/.*"].reject {|i| /\.$/ === i }.sort.each do |i|
	link i, "~/#{i}"
end

