alias ff="find . -name"

alias ls="ls -A --color=auto"
alias ll="ls -lhF"

alias notifyemail="sendmail ${EMAIL_ADDRESS}"
alias notifysms="sendmail ${SMS_NUMBER}@sms.sasktel.net"

alias unmake="make clean uninstall 2> /dev/null"
alias remake="unmake; make"

function mkcd {
    mkdir -p $1 && cd $1
}

function path-contains() {
    if [[ "$PATH" =~ (^|:)"$1"(|/)(:|$) ]]; then
        return 0
    else
        return 1
    fi
}

function path-prepend() {
    if [ path-contains "$1" ]; then
        PATH="${1}:${PATH}"
    fi
}

function path-append() {
    if [ path-contains "$1" ]; then
        PATH="${PATH}:${1}"
    fi
}
