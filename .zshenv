# to avoid overwritten PATH via /usr/libexec/path_helper
# refs. https://github.com/Homebrew/homebrew-core/pull/32074#issuecomment-421381869
unsetopt GLOBAL_RCS

# environment
export LC_ALL=ja_JP.UTF-8
export HOMEBREW_PATH=/usr/local
export DEVEL_PATH=$HOME/devel
export GOPATH=$DEVEL_PATH
export EDITOR=vim

path=(
  $HOME/bin(N-/)
  $DEVEL_PATH/bin(N-/)
  $HOME/.mysqlenv/bin(N-/)
  $HOME/.mysqlenv/shims(N-/)
  $HOME/.pyenv/bin(N-/)
  $HOME/.pyenv/shims(N-/)
  $HOME/.rbenv/bin(N-/)
  $HOME/.rbenv/shims(N-/)
  $HOME/.plenv/bin(N-/)
  $HOME/.plenv/shims(N-/)
  $HOME/.ndenv/bin(N-/)
  $HOME/.ndenv/shims(N-/)
  $HOME/.cargo/bin(N-/)
  $GOPATH/bin(N-/)
  $HOMEBREW_PATH/opt/perl/bin(N-/)
  $HOMEBREW_PATH/opt/node@12/bin(N-/)
  $HOMEBREW_PATH/lib/ruby/gems/2.7.0/bin(N-/)
  $HOMEBREW_PATH/opt/ruby/bin(N-/)
  $HOMEBREW_PATH/opt/mysql-client/bin(N-/)
  $HOMEBREW_PATH/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PATH/bin(N-/)
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)
)

typeset -U manpath
manpath=(
  $HOMEBREW_PATH/share/man(N-/)
  $HOMEBREW_PATH/opt/coreutils/libexec/gnuman(N-/)
  /usr/share/man(N-/)
)

export PAGER=less
export LESS='--LONG-PROMPT --RAW-CONTROL-CHARS'

if whence code 2>&1 >/dev/null; then
  EDITOR='code --wait'
fi

if whence code 2>&1 >/dev/null; then
  EDITOR='code --wait'
fi

MACVIM_APP=
local -a macvim_app_candidates=(
  /opt/homebrew-cask/Caskroom/macvim-kaoriya/*/MacVim.app(N-/)
  $HOMEBREW_PATH/opt/macvim/MacVim.app(N-/)
  $HOME/Applications/MacVim.app(N-/)
  /Applications/MacVim.app(N-/)
)
if (( $#macvim_app_candidates > 0 )); then
  MACVIM_APP="$macvim_app_candidates[1]"
fi
export MACVIM_APP

if [[ -x /usr/libexec/java_home ]] && /usr/libexec/java_home 2>&1 >/dev/null; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
fi

RUBY_CONFIGURE_OPTS=""
openssl_dir="$HOMEBREW_PATH/opt/openssl@1.1"
if [[ -d "$openssl_dir" ]]; then
  RUBY_CONFIGURE_OPTS="${RUBY_CONFIGURE_OPTS} --with-openssl-dir=${openssl_dir}"
fi

readline_dir="$HOMEBREW_PATH/opt/readline"
if [[ -d "$readline_dir" ]]; then
  RUBY_CONFIGURE_OPTS="${RUBY_CONFIGURE_OPTS} --with-readline-dir=${readline_dir}"
fi
export RUBY_CONFIGURE_OPTS
