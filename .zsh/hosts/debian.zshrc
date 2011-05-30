# vim:set ft=zsh:

[ ${STY} ] && screen -X eval "escape ^t^t"

rgrowl() {
	if [[ "x$SSH_CLIENT" = "x" ]]; then
		exit 1
	fi
	local client_host=$( echo $SSH_CLIENT | cut -f1 -d' ' )
	ssh $client_host growlnotify -m "$1" "$HOST"
}

