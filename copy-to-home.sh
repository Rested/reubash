#!/usr/bin/env bash
function checkconflicts () {
    cat ./.aliases.sh | sed 's/^[^# ]* *\|=.*$//g' | while read a; do
    printf "%20.20s : %s\n" $a "$(type -ta $a | tr '\n' ' ')"
    done | awk -F: '$2 ~ /file/'
}
if [[ $(checkconflicts) ]]; then
    echo $(checkconflicts)
    echo "Conflicts found see above, modify alias first"
    exit 1
else
    echo "No conflicts found, safe to go ahead"
fi
cp .aliases.sh ~/.aliases
cp .functions.sh ~/.functions

if [ -f ~/.bashrc ]; then
    echo "Adding to .bashrc if not already there"
    cat ~/.bashrc | grep source | grep .aliases || echo "source ~/.aliases" >> ~/.bashrc
    cat ~/.bashrc | grep source | grep .functions || echo "source ~/.functions" >> ~/.bashrc
fi
if [ -f ~/.zshrc ]; then
    echo "Adding to .zshrc if not already there"
    cat ~/.zshrc | grep source | grep .aliases || echo "source ~/.aliases" >> ~/.zshrc
    cat ~/.zshrc | grep source | grep .functions || echo "source ~/.functions" >> ~/.zshrc
fi