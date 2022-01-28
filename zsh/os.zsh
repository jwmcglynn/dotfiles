function is_linux() {
  if [ "$(uname)" = "Linux" ]; then
    true
  else
    false
  fi
}

function is_macos() {
  if [ "$(uname)" = "Darwin" ]; then
    true
  else
    false
  fi
}
