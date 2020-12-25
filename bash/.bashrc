case $- in
    *i*) ;;
      *) return;;
esac
if [ -n "$DISPLAY" ]; then
    xset b off
fi
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH="$PATH:/sbin"
export EDITOR='vim visudo'
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR
shopt -s autocd









function l () {
    clear && ls -l $1 --group-directories-first
}

function la () {
    clear && ls -lA --group-directories-first
}

function goshow () {
    if [ "$#" -eq 1 ]; then
        cd $1 && la
    fi
}

#my vim convenience function
#if no file is given, start vim in insert mode
#CAREFUL: this function performs fuzzy search in current directory and will open first match
#v bash: open the first match of all files containing "bash" in current directory
#v file 13: open file at line 13
#v file 13 8: open file at line 13 and column 8
function v () {
    FDIR=""
    if [ "$#" -gt 0 ]; then
        FDIR=$(find . -maxdepth 1 -name '*' -type f | grep "$1" | head -1)
        if [ "$FDIR" != "" ]; then
            if [ "$#" -lt 2 ]; then
                vim "$FDIR" && la
            elif [ "$#" -eq 2 ]; then
                vim "$FDIR" +"$2" && la
            elif [ "$#" -eq 3 ]; then
                vim "$FDIR" "+call cursor($2, $3)" && la
            fi
        else
            vim $1 && la
        fi
    else
        vim +star && la
    fi
}

#git function for lazyness that I quickly can call with no need
#to explicitly commit before a push when tinkering with stuff
function lazycommit () {
    if [ "$#" -eq 0 ]; then
        git commit -m "small fix" && git push
    elif [ "$#" -eq 1 ]; then
        git commit -m "$1" && git push
    elif [ "$#" -eq 2 ]; then
        git commit -m "$1" -m "$2" && git push
    else
        echo "lazycommit error: more than 2 args, wtf is going on?"
    fi
}

#case sensitive changedir function such as "cd" and does fuzzy search. also clears screen and lists content
function c () {
    FDIR=""
    if [ "$#" -gt 0 ]; then
        FDIR=$(find . -maxdepth 1 -name '*' -type d | grep "$1" | head -1)
        if [ "$FDIR" != "" ]; then
            cd "$FDIR"
        else
            cd $1
        fi
    else
        cd ~/
    fi
    la
}

#case sensitive back function such as "cd .." and does fuzzy search. also clears screen and lists content
#if current dir is ~/private/books/cpp/bjarne/, then "b riv" will go back to ~/private/
function b () {
    if [ "$#" -gt 0 ]; then
        found=0
        start=$(pwd)
        cur=$(pwd)
        par="$(dirname "$cur")"
        while [[ "$(dirname "$par")" != "/" ]];
        do
            cd ..
            cur=$(pwd)
            par="$(dirname "$cur")"
            basePar="$(basename $(dirname "$cur"))"
            if [[ $basePar == *"$1"* ]]; then
                goshow ..
                found=1
                break
            fi
        done
        if [ $found -eq 0 ]; then
            goshow "$start"
        fi
    else
        goshow ..
    fi
} 

function bb () {
    source ~/.bashrc
}

#copy current directory to clipboard
function pp () {
     pwd | xclip -r -selection clipboard
}

#print the last command
function lastcmd () {
    fc -ln -1 | sed '1s/^[[:space:]]*//'
}

#copy the last command to clipboard
function lastPP () {
    fc -ln -1 | sed '1s/^[[:space:]]*//' | xclip -r -selection clipboard
}

#remove duplicate lines in a file
function removeduplicates () {
    if [ "$#" -eq 1 ]; then
        awk '!seen[$0]++' $1
    fi
}

function vi3 () {
    v ~/.config/i3/config
}

function goi3 () {
    goshow ~/.config/i3/
}

function vx () {
    vim ~/.Xresources && xrdb ~/.Xresources && la
}

function vv () {
    v ~/.vimrc
}

function govim () {
    goshow ~/.vim
}

function vb () {
    vim ~/.bashrc && source ~/.bashrc && la
}

function z () {
    zathura $1 & disown && la
}

function x () {
	xpdf -rv -papercolor "#808080" -fullscreen $1 & disown && la
}

function kk () {
    latexmk -silent -pvc "$1"
}

function xx () {
    rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.toc
}

function f () {
    FDIR=""
    if [ "$#" -gt 0 ]; then
        FDIR=$(ls -d -- */ 2>/dev/null | grep "$1" | head -1)
    else
        FDIR=$(ls -d -- */ 2>/dev/null | head -1)
    fi
    [[ "$FDIR" != "" ]] && goshow "$FDIR"
}

#coloring echo. first argument is terminal color 0-255
#usage example: colorecho 20 "my name is vwisd"
function colorecho () {
    X="\033[0;38;5;"
    Y="m"
    Z="\033[0m"
    if [ "$#" -eq 2 ]; then
        echo -e "$X$1$Y$2$Z"
    fi
}

function fdir () {
    FOUND_DIR=""
    if [ "$#" -gt 0 ]; then
        FOUND_DIR=$(find . -type d -name "*$1*" | head -1)
        cd "$FOUND_DIR"
    else
        echo -e "\033[1;31mfdir needs directory argument\033[0m"
    fi
}

function mkcd () {
    if [ "$#" -eq 1 ]; then
        mkdir -p $1 && cd $1
    else
        echo -e "\033[1;31mmkcd needs directory argument\033[0m"
    fi
}

#system update by checking which os is runnning
#and then running the corresponding package manager
function usys () {
    os=$(cat /etc/*-release | grep "^ID=" | awk -F'[=]' '{ print $2 }')
    case "${os}" in
        debian)
            sudo apt update && sudo apt -y upgrade
            ;;
        arch) 
            sudo pacman -Syy && sudo pacman -Syu
            ;;
    esac
}

#abbrev for make
function m () {
    make -s
}

#abbrev for make clean
function mc () {
    make clean
}

#abbrev for make and run
function mr () {
    make -s && ./prog
}

#abbrev for make and run and clean
function mrc () {
    make -s && ./prog && make clean
}

#abbrev for run
function r () {
    ./prog
}

function e () {
    devour emacs
}

#doom upgrade for doom emacs
function dupgrade () {
    ~/.emacs.d/bin/doom upgrade
}

#doom update packages for doom emacs
function dpack () {
    ~/.emacs.d/bin/doom sync -u
}

#doom sync for doom emacs
function dsync () {
    ~/.emacs.d/bin/doom sync
}

#doom sync and restart doom emacs
function dreload () {
    ~/.emacs.d/bin/doom sync && devour emacs
}

#emacs config (vec - vim emacs config)
function vec () {
    v ~/.doom.d/config.el
}

#emacs packages (vep - vim emacs packages)
function vep () {
    v ~/.doom.d/packages.el
}

#emacs init (vei - vim emacs init)
function vei () {
    v ~/.doom.d/init.el
}

#open doom emacs folder and list content
function godoom () {
    goshow ~/.doom.d/
}

function javac () {
    javac -Xlint:unchecked
}






##██████  ██ ████████ 
#██       ██    ██    
#██   ███ ██    ██    
#██    ██ ██    ██    
##██████  ██    ██    
alias gl='git log'
alias gs='git status'
alias ga='git add'
function gc () {
    if [ "$#" -eq 0 ]; then
        git commit -m "small fix"
    elif [ "$#" -eq 1 ]; then
        git commit -m "$1"
    elif [ "$#" -eq 2 ]; then
        git commit -m "$1" -m "$2"
    else
        echo "git commit error: more than 2 args, wtf is going on?"
    fi
}

export -f colorecho
export -f goshow
export -f l
export -f la
export -f c
export -f b
export -f v
export -f e
