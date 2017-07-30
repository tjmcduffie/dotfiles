
#local tmux
function tmux-session()
{
  tmux -u2 new -s $1 -AD
}

# remote tmux
server[1]='example.com'
function msb() 
{
  srv="${server[$1]}"
  session="$2"
  if [ -z "$1" ] | [ -z "$srv" ]; then
    echo provide a server to connect to
    return 1
  fi

  # this is an IPv6 server so we need the -6 flag
  mosh -6 $srv -- tmux -u2 new -s $session -AD
}

function ssb()
{
  srv="${server[$1]}"
  session="$2"
  if [ -z "$1" ] | [ -z "$srv" ]; then
    echo provide a server to connect to
    return 1
  fi

  if [ -z "$2" ]; then
    args="$srv"
  else
    args="$srv \"tmux -u2cc new -s $session -AD\""
  fi

  ssh -Y -C -t $args
}

# apply profile updates
alias upprof='source ~/.profile'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\h \[\033[32m\]\w\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
