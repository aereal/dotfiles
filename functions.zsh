# vim: set ft=zsh:


function screen-new-window-with-command-as-windot-title() {
	screen -t $1 $@
}

function my-expand-abbrev() {
	local left prefix
	left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
	prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
	LBUFFER=$left${myabbrev[$prefix]:-$prefix}" "
}

function rprompt-git-current-branch {
	# http://d.hatena.ne.jp/uasi/20091025/1256458798
	local name st color gitdir action
	if [[ "$PWD" =~ '\.git(/.*)?$' ]]; then
		return
	fi
	name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
	if [[ -z $name ]]; then
		return
	fi

	gitdir=`git rev-parse --git-dir 2> /dev/null`
	action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

	st=`git status 2> /dev/null`
	if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
		color=%F{green}
	elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
		color=%F{yellow}
	elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
		color=%B%F{red}
	else
		color=%F{red}
	fi

	echo "$color$name$action%f%b "
}

function show_window_title() {
	emulate -L zsh
	local -a cmd
	cmd=(${(z)2})

	case $cmd[1] in
		fg)
			if (( $#cmd == 1 )); then
				cmd=(builtin jobs -l %+)
			else
				cmd=(builtin jobs -l $cmd[2])
			fi
			;;
		%*)
			cmd=(builtin jobs -l $cmd[1])
			;;
		cd)
			if (( $#cmd == 2 )); then
				cmd[1]=$cmd[2]
			fi
			;;
		ls|clear)
			echo -n "k$ZSH_NAME\\"
			return
			;;
		screen|pwd)
			return
			;;
		*)
			echo -n "k$cmd[1]:t\\"
			return
			;;
	esac
	local -A jt
	jt=(${(kv)jobtexts})
	$cmd >>(read num rest
			cmd=(${(z)${(e):-\$jt$num}})
			echo -n "k$cmd[1]:t\\") 2>/dev/null
}

