# vim:set ft=ruby foldmethod=marker:

require 'rake/testtask'
require 'yaml'

lib = File.expand_path("../lib", __FILE__)
$: << lib

require 'bootstrap/sync_file_task'

# Constants {{{
HOME = ENV['HOME']
SRC_DIR = File.dirname(File.expand_path(__FILE__))
REPOSITORY = SRC_DIR
DST_DIR = ENV.fetch('DOTFILES_INSTALL_DIR', HOME)
CONFIG = YAML.load_file(File.join(REPOSITORY, '.dotfiles.yml'))
DOTFILES = CONFIG['dotfiles']
DOTFILES_MAP = DOTFILES.map {|f|
  { basename: f, source: File.join(SRC_DIR, f), installed: File.join(DST_DIR, f) }
}
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

DOTFILES_MAP.each do |dotfile|
  file dotfile[:installed] do
    ln_sf dotfile[:source], dotfile[:installed]
  end
end
# }}}

# Tasks {{{
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
end

desc "Install dotfiles to $HOME"
task :install => DOTFILES_MAP.map {|dotfile| dotfile[:installed] }

desc "Show all dotfiles"
task :list do
  DOTFILES.each do |dotfile|
    puts dotfile
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
# }}}
