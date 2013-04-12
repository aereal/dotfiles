# vim:set ft=ruby:

HOME = ENV['HOME']
SRC_DIR = File.dirname(File.expand_path(__FILE__))
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
