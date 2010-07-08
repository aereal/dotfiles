#!/usr/bin/env ruby

require "pathname"

class String
	def expand
		Pathname.new(self).expand_path
	end
end

WORKPLACE  = '~/sunny_place'.expand
CONFIG_DIR = '~/.sketch'.expand

EXTS = {
	'ruby' => 'rb',
	'perl' => 'pl',
	'python' => 'py',
	'scheme' => 'scm',
	'javascript' => 'js',
}

if $0 == __FILE__
	require "fileutils"

	@lang = ARGV.shift
	@ext = EXTS.fetch(@lang, @lang)
	@editor = ENV['EDITOR'] || 'vi'
	@dir = WORKPLACE + @lang
	@dir.mkpath unless @dir.exist?
	@filename = @dir + "#{Time.now.to_i}.#{@ext}"

	if (CONFIG_DIR + 'skeleton').directory? &&
	   (skeleton = CONFIG_DIR + "skeleton/#{@lang}.#{@ext}").exist?
		FileUtils.cp skeleton.expand_path, @filename
	end

	system(@editor, @filename)
end
