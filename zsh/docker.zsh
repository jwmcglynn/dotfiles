# Returns true if we're in a docker instance.
function is_docker() {
  [ -f /.dockerenv ]
}

DOTFILES_COMMANDS["is_docker"]="Returns true if we're in a docker instance."

# Exit execution if we're not within docker.
if ! is_docker; then
  return
fi

# See https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history
if [ -d /commandhistory ]; then
  touch /commandhistory/.zsh_history
  export HISTFILE="/commandhistory/.zsh_history"
else
  echo "Warning: Could not enable history sharing, there is no /commandhistory directory."
fi
