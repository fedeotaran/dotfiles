# Check if zplug is installed if [[ ! -d ~/.zplug ]]; then git clone https://github.com/zplug/zplug ~/.zplug
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
zplug "agkozak/zsh-z"
zplug "junegunn/fzf-bin",\
    as:command,\
    from:gh-r,\
    rename-to:"fzf",\

zplug "junegunn/fzf",\
    as:command,\
    use:bin/fzf-tmux,\
    on:"junegunn/fzf-bin"

zstyle ':prezto:module:ssh:load' identities 'id_rsa'
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

function reload_nvim {
    for SERVER in $(nvr --serverlist); do
        nvr -cc "source ~/.config/nvim/init.vim" --servername $SERVER &
    done
}
theme(){ alacritty-colorscheme -c ~/.alacritty.yml -a "base16-$1.yml" -V && reload_nvim}
light(){ alacritty-colorscheme -c ~/.alacritty.yml -a base16-github.yml -V && reload_nvim; }
dark(){ alacritty-colorscheme -c ~/.alacritty.yml -a base16-twilight.yml -V && reload_nvim; }
alias ls-theme='_lstheme(){ alacritty-colorscheme -c .alacritty.yml -l }; _lstheme'


# -- Editor
alias vimdiff='nvim -d'
alias vim="nvim"
alias vi="nvim"
export EDITOR="nvim"
# -- fzf --
export FZF_DEFAULT_OPTS='--height 40% --reverse'
export FZF_DEFAULT_COMMAND='ag --ignore-dir venv -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
compinit
#. ~/.asdf/plugins/java/set-java-home.sh
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
export HISTFILE=~/.zsh_history
# export PATH="/Applications/Postgres.app/Contents/Versions/13/bin:$PATH"
