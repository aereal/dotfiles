# vim:set ft=zsh:

export PERLBREW_ROOT=$HOME/perlbrew
[[ -f "$PERLBREW_ROOT/etc/bashrc" ]] && . $PERLBREW_ROOT/etc/bashrc

paths=(
	$HOME/bin
	$GEM_HOME/bin
	$PERLBREW_ROOT/bin
	$PERLBREW_ROOT/perls/current/bin
	$PATH
)

export PATH=${(j.:.)paths}

