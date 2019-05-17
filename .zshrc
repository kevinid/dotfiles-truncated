# Exports {{{
# Reorder PATH so local bin is first
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"
export EDITOR="nvim"
export TERM="xterm-256color"

# oh-my-zsh settings
export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
ZSH_THEME="" # oh-my-zsh theme
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
# Enable the following plugins
plugins=(git python docker zsh-syntax-highlighting zsh-autosuggestions)
# }}}

source $ZSH/oh-my-zsh.sh

# Auto Completions {{{
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# }}}

# Auto suggestions {{{
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_USE_ASYNC="true"
# }}}

# Alias' {{{
alias vi="nvim"
alias r="source ~/.zshrc"
alias python=python3.7 # default python-env
alias pip="python3.7 -m pip" # default pip
# }}}

# Set Options {{{
# ===== Basics
# don't beep on error
setopt no_beep
# Allow comments even in interactive shells (especially for Muness)
setopt interactive_comments
setopt vi

# ===== Changing Directories
## If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt auto_cd
# if argument to cd is the name of a parameter whose value is a valid
# directory, it will become the current directory
setopt cdablevarS
# don't push multiple copies of the same directory onto the directory stack
setopt pushd_ignore_dups

# ===== Expansion and Globbing
# treat #, ~, and ^ as part of patterns for filename generation
setopt extended_glob

# ===== History
# Allow multiple terminal sessions to all append to one zsh command history
setopt append_history
# Save timestamp of command and duration
setopt extended_history
# Add comamnds as they are typed, don't wait until shell exit
setopt inc_append_history
# When trimming history, lose oldest duplicates first
setopt hist_expire_dups_first
# Do not write events to history that are duplicates of previous events
setopt hist_ignore_dups
# Remove command line from history list when first character
# on the line is a space
setopt hist_ignore_space
# When searching history don't display results already cycled through twice
setopt hist_find_no_dups
# Remove extra blanks from each command line being added to history
setopt hist_reduce_blanks
# Don't execute, just expand history
setopt hist_verify
# Imports new commands and appends typed commands to history
setopt share_history

# ===== Completion
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase

unsetopt menu_complete # do not autoselect the first completion entry

# ===== Correction
setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

# ===== Prompt
setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

# ===== Scripts and Functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted
# }}}

# History {{{
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
# }}}

# Prompt {{{
autoload -U promptinit; promptinit
prompt pure
# }}}

