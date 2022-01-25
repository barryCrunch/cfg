# configures an alias for the bare repo used to manage dotfiles
# aka use "config" instead of "git" for this bare repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Crappy shell script that updates the dotfiles
alias envupdate='$HOME/.utilities/update.sh'

# Ensures that ipython is always opened within the working virtualenv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
