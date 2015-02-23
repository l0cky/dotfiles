#!/bin/bash

# You have installed stow or not?

if [[ $(dpkg-query -l 'stow' | grep -o '^ii') -ne 'ii' ]]; then
  printf "Stow is not installed in your computer.\nPlease install it first.\n"
else
  printf "Stow is installed in your computer.\n"
fi

# Link git configs

stow -v git

exit 0
