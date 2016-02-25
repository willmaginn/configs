alias ..='cd ..'

# alias home='cd ~/'
# This is really overkill as you can just call 'cd' and that
# will bring you into the home directory
alias home='cd'

alias web='cd /Library/WebServer/Documents/projects/'
alias cloud='cd ~/CloudDrive/Will/Projects/; clear; ls'

# alias elsie='ssh -p 0000 user@000.00.00.00'
# There is a much cleaner way to do this, when using ssh_config file
# and the host is configured in there, you can just call 'ssh host'
alias elsie='ssh elsie'

alias hosts='sudo vi /etc/hosts'
alias vhosts='sudo vi /etc/apache2/extra/httpd-vhosts.conf'
alias apr='sudo apachectl restart'

alias flush='dscacheutil -flushcache'
source ~/wp-completion.bash