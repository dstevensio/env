# System-wide .bashrc file for interactive bash(1) shells.
if [ -n "$PS1" ]; then PS1='\h:\w \u\$ '; fi
# Make bash check it's window size after a process completes
shopt -s checkwinsize

source ~/src/git-1.6.0.5/contrib/completion/git-completion.bash

##################################
# General Aliases
##################################
alias l='ls -l'
alias ll='ls -la'
alias lll='ls -asl | more'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias rmsvn='find . -name .svn -print0 | xargs -0 rm -rf'
alias myipbitch='ipconfig getifaddr en0'
alias rbash='. ~/.bash_profile'
alias ebash='vi ~/.bash_profile'
alias ehosts='sudo vi /etc/hosts'
alias ss='script/server'
alias musicmnt='~/scripts/music/music_mount.sh'
alias musicunmnt='~/scripts/music/music_unmount.sh'
alias scpresume='rsync --partial --progress --rsh=ssh'
alias sshfs='/Applications/sshfs/bin/mount_sshfs'
alias unmount='/usr/sbin/diskutil unmount'

##################################
# Local Drupal Aliases
##################################
alias drush='~/src/drush/drush'
alias dp='cd ~/Sites/drupal'
alias dpthemes='cd ~/Sites/drupal/sites/all/themes'
alias dpmodules='cd ~/Sites/drupal/sites/all/modules'

##################################
# MySQL Related
##################################
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias mysqlstart="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias mysqlstop="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"

##################################
# Apache Related
##################################
alias apache_bounce='sudo apachectl graceful'
alias apache_stop='sudo apachectl stop'
alias apache_start='sudo apachectl start'
alias apache_httpd='sudo vi /etc/apache2/httpd.conf'
alias apache_vhosts='sudo vi /etc/apache2/extra/httpd-vhosts.conf'
alias elog='tail -f /var/log/apache2/error_log'
alias logs='~/scripts/apache_logs.sh'

##################################
# CouchDB Related
##################################
alias cdbstart='sudo launchctl load /usr/local/Library/LaunchDaemons/org.apache.couchdb.plist'
alias cdbstop='sudo launchctl unload /usr/local/Library/LaunchDaemons/org.apache.couchdb.plist'
alias cdbwww='cd /usr/local/share/couchdb/www'

##################################
# Bash Color and Configuration
##################################
CLICOLOR="YES";    
export CLICOLOR
LSCOLORS="ExGxFxdxCxDxDxhbadExEx";    
export LSCOLORS
#export PS1="\u:\w > "
export PS1="\[\e[32;1m\]\u@\h:\w$ \[\e[0m\]"

test -r /sw/bin/init.sh && . /sw/bin/init.sh

# rvm-install added:
if [[ -s /Users/gberger/.rvm/scripts/rvm ]] ; then source /Users/gberger/.rvm/scripts/rvm ; fi

