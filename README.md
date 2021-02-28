# My configs/dot-files

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
# ~/.config/tmux/tmux.conf
#
source-file $CUSTOM_CONFIG_HOME/tmux/tmux.conf
```

## Neovim

```vim script
"
" ~/.config/nvim/init.vim
"
source $CUSTOM_CONFIG_HOME/nvim/init.vim
```

## Alacritty

Doesn't seem to expand the variable so this path has to be set manually.

```yaml
# Configuration for Alacritty, the GPU enhanced terminal emulator.

# Import additional configuration files
#
# These configuration files will be loaded in order, replacing values in files
# loaded earlier with those loaded later in the chain. The file itself will
# always be loaded last.
import:
  - .custom_config/configs/alacritty/alacritty.yml
```
