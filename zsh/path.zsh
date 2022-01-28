# Functions to append/prepend elements to path.
# See https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function path_append() {
  for ARG in "$@"; do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
      PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

DOTFILES_COMMANDS["path_append"]="Append arg to \$PATH."

function path_prepend() {
  for ((i=$#; i>0; i--)); do
    ARG=${(P)i}
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
      PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}

DOTFILES_COMMANDS["path_prepend"]="Prepend arg on \$PATH."
