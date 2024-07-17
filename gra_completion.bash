function _gra_completion {

    _args="-h --help"

    # Add config values to completion
    if [ "${#COMP_WORDS[@]}" -lt 3 ] && [ -f ~/.config/gra.config ]; then
        readarray -t lines < ~/.config/gra.config
        for line in "${lines[@]}"; do
            [[ "$line" =~ ^(.*)= ]] && _args="$_args ${BASH_REMATCH[1]}"
        done
    fi

    COMPREPLY=($(compgen -W "$_args" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F _gra_completion gra
