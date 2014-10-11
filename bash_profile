# -*- shell-script -*-

path_remove()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }

if [[ :$PATH: == *:.:* ]]; then
    path_remove .
fi

# Setting PATH -- last entries take priority
export PATH="/usr/local/bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"
export PATH="/usr/local/mysql/bin:${PATH}"

export LC_ALL="en_US.UTF-8"
export PS1="\w \$ "

if [ "`uname -s`" == "Darwin" ]; then
   # OS X
   export PATH="/usr/local/texlive/2013/bin/x86_64-darwin:${PATH}"
   export PKG_CONFIG_PATH="/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig:${PKG_CONFIG_PATH}"
   export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
   export EDITOR="/usr/local/Cellar/emacs/24.3/bin/emacsclient --alternate-editor emacs"

   export CLICOLOR=1
   # export LSCOLORS=ExFxCxDxBxegedabagacad # light background
   export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # dark background
else
   # Linux
   export PATH="/usr/share/java/apache-ant/bin:${PATH}"
   export PATH="/opt/android-sdk/tools:${PATH}"
   export EDITOR="/usr/bin/emacsclient --alternate-editor emacs"
   export GPG_TTY=$(tty)
   alias ls="ls --color=auto"
fi

# CUDA settings
export PATH="/usr/local/cuda/bin:${PATH}"
export DYLD_LIBRARY_PATH="/usr/local/cuda/lib:${DYLD_LIBRARY_PATH}"

alias g='git'
alias l='ls'
alias lal='ls -al'
alias ll='ls -l'
alias lss='ls -lSr'

cl() {
     cd $1 && ll
}

unset -f path_remove
