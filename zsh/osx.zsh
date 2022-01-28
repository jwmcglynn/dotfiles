path_prepend "/opt/homebrew/opt/llvm/bin"
path_append "$HOME/bin/flutter/bin"

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include -I/usr/local/opt/llvm/include/c++/v1/"
