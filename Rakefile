# vim:set ft=ruby:

require "fileutils"
require "pathname"
require "yaml"

HOME      = Pathname(ENV['HOME'])
PWD       = Pathname.pwd
CONFIG    = YAML.load_file(PWD + 'dotfiles.yaml')
DOTFILES  = FileList[(PWD + '.*').to_s].exclude(/\.$/)
HOMEFILES = FileList[(HOME + '.*').to_s].exclude(/\.$/)

[
	CONFIG['__GLOBAL__'],
	CONFIG['OS'][`uname`.strip],
	CONFIG['Host'][ENV['HOST']],
].select {|patterns| patterns.is_a? Hash }.each do |patterns|
	DOTFILES.include *patterns.fetch('include', [])
	DOTFILES.exclude *patterns.fetch('exclude', [])
	HOMEFILES.include *patterns.fetch('include', [])
	HOMEFILES.exclude *patterns.fetch('exclude', [])
end

COPYFILES = DOTFILES.pathmap("#{HOME}/%f")

MODE = 
	case ENV["MODE"] || CONFIG["mode"]
	when /^d(?:ry(?:run)?)?$/
		include FileUtils::DryRun
		:dryrun
	when /^v(?:erbose)?$/
		include FileUtils::Verbose
		:verbose
	when /^(?:nw|nowrite)$/
		include FileUtils::NoWrite
		:nowrite
	else
		include FileUtils
		:default
	end

def sh(*args)
	STDERR.puts args.join(" ") if MODE == :dryrun || MODE == :verbose
	system *args unless MODE == :dryrun || MODE == :nowrite
end

task :default => :usage

desc "show usage messages"
task :usage do
	STDOUT.puts <<USAGE
Install/Export dotfiles to your home
	$ ls -AF
	.bashrc .vimrc .vim/
	$ ls -AF ~
	$ rake install
	$ ls -AF ~
	.bashrc@ .vimrc@ .vim@

	Make symlink which refer to working directory's file in your home,
	or copy files from working directory.

	!!! If a file exists in your home and working directory, it is replaced by working directory's one.

Uninstall dotfiles from your home
	$ ls -AF ~
	.bashrc@ .vimrc .vim@
	$ rake uninstall
	$ ls -AF ~
	.vimrc.uninstalled

	Remove symlink from your home, but normal files which copied are suffixed
	to `.uninstalled'.


Import dotfiles from your home
	$ ls -AF ~
	.gvimrc .vimrc@
	$ ls -AF
	.vimrc
	$ rake import
	$ ls -AF
	.gvimrc .vimrc

	Copy files which not in working directory to working directory,
	and you may run `rake install' or something else.

USAGE
end

desc "install dotfiles"
task :install => :uninstall do
	DOTFILES.existing.each do |file|
		ln_s file, file.pathmap("#{HOME}/%f")
	end
end

desc "uninstall dotfiles"
task :uninstall do
	COPYFILES.existing.each do |file|
		if File.symlink? file
			rm file
		else
			mv file, file.pathmap("%p.uninstalled")
		end
	end
end

desc "import dotfiles"
task :import do
	unmanaged = FileList[HOMEFILES.pathmap('%f') - DOTFILES.pathmap('%f')]
	unmanaged.each do |f|
		cp_r HOME + f, PWD + f
	end
end

desc "export dotfiles"
task :export => :install

namespace :osx do
	LOCALIZATIONS = FileList[(HOME + "*/.localized").to_s]

	desc "remove .localized from directories"
	task :unlocalize => LOCALIZATIONS do |t|
		t.prerequisites.each do |p|
			mv p, p.ext("old")
		end
	end

	namespace :defaults do
		DEFAULTS_CONFIG = YAML.load_file(PWD + "defaults.yaml")

		desc "write defaults"
		task :write do
			DEFAULTS_CONFIG.each do |domain, config|
				config.each do |key, value|
					sh "defaults write #{domain} #{key} #{value}"
				end
			end
		end
	end
end

