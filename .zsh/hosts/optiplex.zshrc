# vim:set ft=zsh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

init_prompt() {
	first_line="%{${fg[yellow]}%}<%n@%m>"
	[[ -n "$rvm_ruby_string" ]] && first_line="$first_line %{${fg[red]}%}($rvm_ruby_string)"
	second_line=" %{${fg[green]}%}S | v | Z %{${reset_color}%}< "
	PROMPT="${first_line}
${second_line}"
	RPROMPT="[%{${fg[yellow]}%}%~%{${reset_color}%}]"
}

precmd_functions=($precmd_functions init_prompt)
