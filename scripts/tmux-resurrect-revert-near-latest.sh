#!/bin/sh

echo "====> Remove wrong backup"
rm `find ${HOME}/.local/share/tmux/resurrect -type f -exec ls -t1 {} + | head -1`

echo "=====> Symlink near latest to last"
ln -sf `find ${HOME}/.local/share/tmux/resurrect -type f -exec ls -t1 {} + | head -1` last
