HOME = ENV['HOME'] || File.expand_path('~')

DOTFILES_REPOSITORY = 'git://github.com/aereal/dotfiles.git'
DOTFILES_DIR        = File.expand_path('~/repos/@aereal/dotfiles')
DOTFILES = %w(
  .caprc
  .gemrc
  .gitconfig
  .gvimrc
  .powenv
  .proverc
  .pryrc
  .rbenv
  .tmux.conf
  .uim
  .vim
  .vimrc
  .zsh
  .zshenv
  .zshrc
)

VIM_DIR              = File.join(DOTFILES_DIR, '.vim')
VIM_BUNDLE_DIR       = File.join(VIM_DIR, 'bundle')
NEOBUNDLE_DIR        = File.join(VIM_BUNDLE_DIR, 'neobundle.vim')
NEOBUNDLE_REPOSITORY = 'git://github.com/Shougo/neobundle.vim'
VIMPROC_SO_FILE      = File.join(VIM_BUNDLE_DIR, 'vimproc', 'autoload', 'vimproc_mac.so')

HOMEBREW_DIR = ENV['HOMEBREW_HOME'] || '/usr/local'

# すべての formula のインストール・タスクを作るオプションがあってもいいかも
FORMULAE = %w(
  coreutils git git-flow haskell-platform hub
  imagemagick io libpng lv mongodb mysql node
  openssl readline redis refe tig zsh
  curl scala haskell-platform python io
  lua gauche wget tmux reattach-to-user-namespace
)

RBENV_HOME = ENV['RBENV_HOME'] || File.join(HOME, '.rbenv')

def home(basename)
  File.join(HOME, basename)
end

def cellar(formula)
  File.join(HOMEBREW_DIR, 'opt', formula)
end

def Cellar(*formulae)
  formulae.map {|_| cellar(_) }
end

def brew_install(*args)
  sh 'brew', 'install', *args
end

def identifierize(string)
  string.strip.gsub(/\W/, '_')
end

def formula_task(formula_name, *args)
  namespace identifierize(formula_name).intern do
    file cellar(formula_name) do
      brew_install(formula_name, *args)
    end

    task :install => [:'homebrew:setup', cellar(formula_name)]
  end
end

namespace :homebrew do
  file File.join(HOMEBREW_DIR, 'bin', 'brew') do
    sh 'ruby -e $(curl -fsSkL raw.github.com/mxcl/homebrew/go)'
  end

  file File.join(HOMEBREW_DIR, 'Library', 'Taps', 'aereal-aereal') do
    sh 'brew', 'tap', 'aereal/aereal'
  end

  desc 'Install Homebrew'
  task :install => File.join(HOMEBREW_DIR, 'bin', 'brew')

  task :create_tap => [:install, File.join(HOMEBREW_DIR, 'Library', 'Taps', 'aereal-aereal')]

  desc 'Setup Homebrew'
  task :setup => :install

  FORMULAE.each do |formula|
    formula_task(formula)
  end

  namespace :group do
    namespace :dev do
      desc 'Install development requirements w/Homebrew'
      task :install => Cellar('git', 'refe', 'tig', 'tmux', 'wget', 'zsh', 'coreutils', 'reattach-to-user-namespace')
    end

    namespace :lang do
      desc 'Install preferred language runtimes w/Homebrew'
      task :install => Cellar('haskell-platform', 'io', 'scala', 'python', 'gauche', 'lua')
    end

    namespace :utils do
      desc 'Install some utilities w/Homebrew'
      task :install => Cellar('jq', 'keychain', 'proctools')
    end
  end
end

DOTFILES.each do |dotfile|
  file File.join(HOME, dotfile) do
    safe_ln File.join(DOTFILES_DIR, dotfile), home(dotfile)
  end
end

namespace :dotfiles do
  file DOTFILES_DIR do
    sh 'git', 'clone', '--recursive', DOTFILES_REPOSITORY
  end

  desc 'Install dotfiles'
  task :install => [DOTFILES_DIR]
end

namespace :vim do
  file NEOBUNDLE_DIR do
    sh 'git', 'clone', NEOBUNDLE_REPOSITORY, NEOBUNDLE_DIR
  end

  file VIMPROC_SO_FILE do
    sh 'make', '-f', File.join(VIM_BUNDLE_DIR, 'vimproc', 'make_mac.mak')
  end

  task :neobundle_install => [NEOBUNDLE_DIR] do
    sh 'vim', '+NeoBundleInstall', '+quit'
  end

  desc 'Setup Vim environment'
  task :setup => [home('.vimrc'), home('.gvimrc'), home('.vim'), :neobundle_install, VIMPROC_SO_FILE]
end

namespace :tmux do
  desc 'Setup tmux environment'
  task :setup => [home('.tmux.conf')]
end

namespace :zsh do
  desc 'Setup zsh environment'
  task :setup => [home('.zsh.d'), home('.zshenv'), home('.zshrc')]
end

namespace :ruby do
  load "./rakefiles/ruby.rake"

  RubyInstall::Task.new('1.9.3-p362', :opt_dirs => Cellar('readline', 'openssl', 'libyaml'))
end
