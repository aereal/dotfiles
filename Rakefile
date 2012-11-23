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
  lua gauche
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
      task :install => Cellar('git', 'hub', 'refe', 'tig', 'tmux', 'wget', 'zsh', 'coreutils')
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
  task :setup => [home('.zsh'), home('.zshenv'), home('.zshrc')]
end

# Ruby

def ruby_version_dir(version)
  File.join(RBENV_HOME, 'versions', version)
end

namespace :ruby do
  namespace :v193p327 do
    file ruby_version_dir('1.9.3-p327') do
      url = 'http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p327.tar.gz#96118e856b502b5d7b3a4398e6c6e98c'
      mkdir 'src'
      cd 'src' do
        # Retrieving sources
        sh 'curl', '-sSLf', url
        sh 'tar', 'xzf', 'ruby-1.9.3-p327.tar.gz' # TODO basename from URL

        cd 'ruby-1.9.3-p327' do
          opt_dirs = [cellar('readline'), cellar('libyaml'), cellar('openssl')]
          sh "./configure",
            "--prefix=#{ruby_version_dir('1.9.3-p327')}",
            "--enable-shared",
            "--with-out-ext=tk,tk/*",
            "--with-opt-dir=#{opt_dirs.join(':')}"
          sh 'make'
          sh 'make install'
        end
      end
    end

    desc 'Install Ruby 1.9.3 p327'
    task :install => [ruby_version_dir('1.9.3-p327')]
  end
end
