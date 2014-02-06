# vim:set ft=ruby foldmethod=marker:

require 'rake/testtask'
require 'yaml'

lib = File.expand_path("../lib", __FILE__)
$: << lib

require 'bootstrap/sync_file_task'
require 'dotfiles'

# Constants {{{
HOME = ENV['HOME']
SRC_DIR = File.dirname(File.expand_path(__FILE__))
REPOSITORY = SRC_DIR
DEST_DIR = ENV.fetch('DOTFILES_INSTALL_DIR', HOME)
IGNORED_DOTFILES = FileList.new(*File.read('.dotfiles.ignore').split("\n"))
DOTFILES_SRCS = FileList['.[^.]*'].exclude(*IGNORED_DOTFILES)
DEFAULTS_SCRIPTS = FileList['osx/defaults/**/*.bash']
# }}}

# File tasks {{{
SyncFileTask.new("setup:osx:aqua_skk") do |t|
  t.source_file      = File.expand_path("~/Dropbox/skk/skk-jisyo.utf8")
  t.destination_file = File.expand_path("~/Library/Application Support/AquaSKK/skk-jisyo.utf8")
  t.install_method   = :copy
end

SyncFileTask.new("setup:osx:kobito") do |t|
  t.source_file      = File.expand_path("~/Dropbox/Kobito.db")
  t.destination_file = File.expand_path("~/Library/Application Support/Kobito/Kobito.db")
  t.install_method   = :symlink
end

SyncFileTask.new("setup:osx:keyremap4macbook") do |t|
  t.source_file      = File.expand_path("~/repos/@aereal/dotfiles/osx/keyremap4macbook/private.xml")
  t.destination_file = File.expand_path("~/Library/Application Support/KeyRemap4MacBook/private.xml")
  t.install_method   = :symlink
end

SyncFileTask.new("setup:sketches") do |t|
  t.source_file      = File.expand_path("~/Dropbox/sketches")
  t.destination_file = File.expand_path("~/sketches")
  t.install_method   = :symlink
end

SyncFileTask.new("setup:memo") do |t|
  t.source_file      = File.expand_path("~/Dropbox/memo")
  t.destination_file = File.expand_path("~/memo")
  t.install_method   = :symlink
end
# }}}

# Tasks {{{
namespace :dotfiles do
  desc "Test dotfiles installations"
  task :test => DOTFILES_SRCS do |t|
    source_and_destinations = t.prerequisites.
      map {|prereq| [File.join(SRC_DIR, prereq), File.join(DEST_DIR, prereq)] }
    results = source_and_destinations.
      map {|(src, dest)| Dotfiles.assert_linked_dotfile(src, dest) }
    exit results.all?
  end

  desc "Install dotfiles"
  task :install => DOTFILES_SRCS do |t|
    t.prerequisites.each do |prereq|
      src = File.join(SRC_DIR, prereq)
      dest = File.directory?(src) ? DEST_DIR : File.join(DEST_DIR, prereq)
      ln_sf src, dest
    end
  end
end

if dircolors = %w( gdircolors dircolors ).find {|cmd| system "which #{cmd} >/dev/null" }
  namespace :dircolors_solarized do
    Dir["#{REPOSITORY}/colors/dircolors-solarized/dircolors.*"].each do |dircolor_file|
      name = File.basename(dircolor_file).gsub(/dircolors\./, '').gsub(/\W/, '_')

      namespace name do
        desc "Install #{name}"
        task :install do
          ret = `#{dircolors} #{dircolor_file} 2>/dev/null`.strip
          open("#{HOME}/.dircolors", "w") do |f|
            f << ret
          end
        end
      end
    end
  end
end

namespace :setup do
  namespace :osx do
    desc "Setup OS X preferences"
    task :defaults => DEFAULTS_SCRIPTS do |t|
      t.prerequisites.each do |prereq|
        system 'bash', prereq
      end
    end
  end
end

namespace :homebrew do
  task :bundle => 'Brewfile' do |t|
    sh 'brew', 'bundle'
  end
end
# }}}
