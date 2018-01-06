# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

# Self manage
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Prezto
zplug 'modules/environment',              from:prezto
zplug 'modules/utility',                  from:prezto
zplug "modules/prompt",                   from:prezto
zplug 'modules/editor',                   from:prezto
zplug "modules/history",                  from:prezto
zplug "modules/syntax-highlighting",      from:prezto
zplug 'modules/history-substring-search', from:prezto, defer:2
zplug 'modules/completion',               from:prezto
zplug 'modules/archive',                  from:prezto
zplug 'modules/directory',                from:prezto
zplug 'modules/ssh',                      from:prezto
zplug "modules/node",                     from:prezto
zplug "modules/python",                   from:prezto
zplug "modules/ruby",                     from:prezto
zplug "modules/git",                      from:prezto

zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'cespi_rsa'
zstyle ':prezto:module:prompt' theme 'sorin'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:git:alias' skip 'yes'
zstyle ':prezto:module:git:status:ignore' submodules 'all'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source packages and add commands to $PATH
zplug load

# export variables
export EDITOR="vi"
# -- npm --
export PATH="$HOME/.npm-global/bin:$PATH"
# -- yat.sh --
export PATH="$HOME/.yat.sh/bin:$PATH"
# -- rbenv --
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# -- pyenv --
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# -- nvm --
export NVM_DIR="/home/fedeotaran/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# -- go --
export PATH=$PATH:/usr/local/go/bin
# -- divenv --
eval "$(direnv hook zsh)"
# -- fzf --
export FZF_DEFAULT_OPTS='--height 40% --reverse'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
