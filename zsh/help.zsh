declare -A DOTFILES_COMMANDS

DOTFILES_COMMANDS["myhelp"]="Print this help message."

# Returns true if we're in a docker instance.
function myhelp() {
  echo "Known commands:"

  output=""
  first=false
  for command in "${(@ki)DOTFILES_COMMANDS}"; do
    if [ "$first" = false ]; then
      first=true
    else
      output="$output\n"
    fi
    output="$output$command\t${DOTFILES_COMMANDS[$command]}"
  done

  echo "$output" | column -t -s $'\t'
}
