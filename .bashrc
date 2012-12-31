# ゆーてぃーえふえいとだよっ
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export PATH=/usr/local/bin:$PATH
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

alias vhttpd='sudo vim /etc/apache2/httpd.conf'
alias httpdrestart='sudo /usr/sbin/apachectl graceful'


# manga
alias cdzip='find . -type d ! -name "." | xargs -I% zip -r -0 "%".zip "%"'
alias cdmv='find . -type d | grep ".*/.*/.*" | xargs -I% mv "%" ./'
alias finddir='find . -type d ! -name "."'
function cdrn() { find . -type d ! -name "." | xargs -I% rename "s/${1}/${2}/" "%"; }
function comicrn() { local arg1="${1}";cdrn ".*([0-9]{2}).*" "${arg1} 第\$1巻"; }
function ziprn() { find . -name "*.zip" ! -name "." | xargs -I% rename "s/${1}.zip/${2}.zip/" "%"; }
function comicziprn() { local arg1="${1}";ziprn ".*([0-9]{2}).*" "${arg1} 第\$1巻"; }
