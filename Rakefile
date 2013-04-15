# vim:set ft=ruby:

HOME = ENV['HOME']
SRC_DIR = File.dirname(File.expand_path(__FILE__))
REPOSITORY = SRC_DIR
DST_DIR = HOME
DOTFILES = %w(
  .caprc
  .gemrc
  .gitconfig
  .global.gitignore
  .gvimrc
  .powenv
  .proverc
  .pryrc
  .tmux.conf
  .vim
  .vimrc
  .zsh.d
  .zshenv
  .zshrc
).map {|f| "#{SRC_DIR}/#{f}" }

DOTFILES.each do |dotfile|
  file "#{DST_DIR}/#{dotfile}" do
    ln_sf "#{SRC_DIR}/#{dotfile}", "#{DST_DIR}/#{dotfile}"
  end
end

desc "Install dotfiles to $HOME"
task :install => DOTFILES

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
