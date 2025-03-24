# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"\

# Conda
eval "$(conda "shell.$(basename "${SHELL}")" hook)"

# Doom Emacs
export PATH="$HOME/.config/emacs/bin:$PATH"
export DOOMDIR="$HOME/dotfiles/config/doom"

# Guile Paths
export GUILE_LOAD_PATH="/opt/homebrew/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/opt/homebrew/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/opt/homebrew/lib/guile/3.0/extensions"

export GUILE_LOAD_PATH=$GUILE_LOAD_PATH:/usr/local/share/guile/site/3.0/
export GUILE_LOAD_COMPILED_PATH=$GUILE_LOAD_COMPILED_PATH:/usr/local/lib/guile/3.0/site-ccache/
export GUILE_SYSTEM_EXTENSIONS_PATH=$GUILE_SYSTEM_EXTENSIONS_PATH:/usr/local/lib/guile/3.0/extensions
export PATH=/usr/local/bin:$PATH