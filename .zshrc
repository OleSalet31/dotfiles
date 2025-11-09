# --- Prompt setup ---
autoload -Uz promptinit        # load prompt system
promptinit
prompt adam1                   # use the "adam1" theme

setopt histignorealldups       # remove older dupes from history
setopt sharehistory            # share history across sessions

bindkey -e                     # emacs-style keybindings

# --- History ---
HISTSIZE=1000                  # lines kept in memory
SAVEHIST=1000                  # lines saved to file
HISTFILE=~/.zsh_history        # history file path

# --- Completion system ---
autoload -Uz compinit          # load completion system
compinit

zstyle ':completion:*' auto-description 'specify: %d'            # show what’s expected
zstyle ':completion:*' completer _expand _complete _correct _approximate  # completion chain
zstyle ':completion:*' format 'Completing %d'                     # group header format
zstyle ':completion:*' group-name ''                              # group results by tag
zstyle ':completion:*' menu select=2                              # start menu after 2 matches
eval "$(dircolors -b)"                                           # enable ls colors (bash format)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}    # colorize completion lists
zstyle ':completion:*' list-colors ''                             # fallback (no extra colors)
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s  # pager prompt
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*' # smart matching
zstyle ':completion:*' menu select=long                           # use full-screen selector
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s  # selector hint
zstyle ':completion:*' use-compctl false                          # disable old compctl
zstyle ':completion:*' verbose true                               # show extra info

# Process completion: color & listing for `kill`
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'  # highlight PIDs
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'   # process format

# --- Minimal Git branch on right prompt ---
autoload -Uz vcs_info          # VCS metadata provider
precmd() { vcs_info }          # refresh VCS info before each prompt

setopt promptsubst             # allow ${...} expansion in prompts

zstyle ':vcs_info:git:*' formats '(%b)'        # show branch name: (branch)
zstyle ':vcs_info:git:*' actionformats '(%b|%a)' # show action too: (branch|action)

RPROMPT='${vcs_info_msg_0_}'   # put branch info on the right
