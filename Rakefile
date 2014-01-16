# vim:set ft=ruby foldmethod=marker:

require 'rake/testtask'
require 'yaml'

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
# }}}

DOTFILES_MAP.each do |dotfile|
  file dotfile[:installed] do
    ln_sf dotfile[:source], dotfile[:installed]
  end
end

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
# }}}
