#!/usr/bin/env bash
cp .aliases.sh ~/.aliases
cp .functions.sh ~/.functions
cat ~/.bashrc | grep source | grep .aliases || echo "source ~/.aliases" >> ~/.bashrc
cat ~/.bashrc | grep source | grep .functions || echo "source ~/.functions" >> ~/.bashrc