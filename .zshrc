# Allow comments in interactive shell (so pasted scripts with # work)
setopt interactivecomments

# --- History ---
HISTSIZE=1000                    # lines kept in memory
SAVEHIST=1000                    # lines saved to file
HISTFILE=~/.zsh_history          # history file path

setopt histignorealldups         # remove older dupes from history
setopt sharehistory              # share history across sessions

# --- Keybindings ---
bindkey -v                       # vim-style keybindings

# --- Prompt setup ---
autoload -Uz promptinit
promptinit

# Simple prompt: "user@host dir %"
# No colors so the my GNOME Terminal theme controls the look.
PROMPT='%n@%m %1~ %# '
RPROMPT=''   # RPROMPT will be set by vcs_info section below

setopt promptsubst               # allow ${...} in prompts

# --- Completion system ---
autoload -Uz compinit            # load completion system
compinit

zstyle ':completion:*' auto-description 'specify: %d'                     # show what’s expected
zstyle ':completion:*' completer _expand _complete _correct _approximate  # completion chain
zstyle ':completion:*' format 'Completing %d'                             # group header format
zstyle ':completion:*' group-name ''                                      # group results by tag
zstyle ':completion:*' menu select=2                                      # start menu after 2 matches

# Use LS_COLORS for completion colouring
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"                                                  # enable ls colors
  zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
fi

zstyle ':completion:*' list-colors ''                                     # fallback (no extra colors)
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s                # pager prompt
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'     # smart matching
zstyle ':completion:*' menu select=long                                   # use full-screen selector
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s  # selector hint
zstyle ':completion:*' use-compctl false                                  # disable old compctl
zstyle ':completion:*' verbose true                                       # show extra info

# Process completion: color & listing for `kill`
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'  # highlight PIDs
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'   # process format

# --- Minimal Git branch via vcs_info ---  
autoload -Uz vcs_info          # VCS metadata provider
precmd() { vcs_info }          # refresh VCS info before each prompt

zstyle ':vcs_info:git:*' formats '(%b)'           # show branch name: (branch)
zstyle ':vcs_info:git:*' actionformats '(%b|%a)'  # show action too: (branch|action)

# put branch info on the right
RPROMPT='${vcs_info_msg_0_}'

# --- Aliases ---
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Default editor
export EDITOR=vim
