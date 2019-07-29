# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

touch ~/ec2-name;
ec2_name=`cat ~/ec2-name`

export PS1='\[\033[0;32m\]$ec2_name:\[\033[36m\]\w\[\033[0m\] \$ ';
