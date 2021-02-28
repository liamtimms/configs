# My configs (and dot files)

I previously tried just symlinking files from `$XDG_CONFIG_HOME` but found managing different machines to be a little annoying so I've just switched over to sourcing repo files from local copies. The following are templates for sourcing files from this repo.

## BASH

This defines `$CUSTOM_CONFIG_HOME` and sources the file from here.

```bash
#
# ~/.bashrc
#
export XDG_CONFIG_HOME=~/.config/

# cloned config repo folder
export CUSTOM_CONFIG_HOME=~/.custom_config/configs/

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $CUSTOM_CONFIG_HOME/shell/bashrc_arch
```
and inputrc:

```bash
$include /home/mri/.custom_config/configs/shell/inputrc
```


## TMUX

```bash
#
# ~/config/tmux/tmux.conf
#
source-file $CUSTOM_CONFIG_HOME/tmux/tmux.conf
```


