function is_linux() {
  [ "$(uname)" = "Linux" ]
}

DOTFILES_COMMANDS["is_linux"]="Returns true on Linux\n \tif is_linux; then echo \"linux\"; fi"

function is_macos() {
  [ "$(uname)" = "Darwin" ]
}

DOTFILES_COMMANDS["is_macos"]="Returns true on macos.\n \tif is_macos; then echo \"macos\"; fi"
