alias ls='ls --color'
alias ll='ls --color -lh'

if [ -f '/google-cloud-sdk/completion.bash.inc' ]; then
    source '/google-cloud-sdk/completion.bash.inc'
fi

source /etc/profile.d/bash_completion.sh
source <(kubectl completion bash)
