#!/bin/bash
# http://blog.hawkhost.com/2010/07/02/tmux-%E2%80%93-the-terminal-multiplexer-part-2/
# zpresto was renaming the window titles to truncated path, commented off one
# setting in zpreztorc to fix this. auto-title terminal.
export WDIR="/Users/rahul/work/projects/rbcurse/examples"
export LDIR="/Users/rahul/work/projects/rbcurse/lib"
cd /Users/rahul/work/projects/rbcurse/examples
tmux new-session -d -s rbcurse -n "jed"
 
tmux new-window -t rbcurse:1 -n 'examples' zsh
tmux new-window -t rbcurse:2 -n 'Issues' zsh
tmux new-window -t rbcurse:3 -n 'run' zsh
tmux new-window -t rbcurse:4 -n 'todo' zsh 
tmux new-window -t rbcurse:5 -n 'Ack' "cd $LDIR; zsh"
tmux new-window -t rbcurse:6 -n 'rubydoc' /opt/local/bin/links file:///Users/rahul/Documents/ruby/ruby_1_9_2_core/index.html
tmux new-window -t rbcurse:7 -n 'irb' irb
tmux new-window -t rbcurse:8 -n 'me' zsh
tmux new-window -t rbcurse:9 -n 'VER' "cd $LDIR; zsh"
tmux send-keys -t rbcurse:9 'vim rbcurse/'
tmux send-keys -t rbcurse:8 'me'
 
tmux select-window -t rbcurse:3
tmux -2 attach-session -t rbcurse

