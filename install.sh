#!/bin/bash


## Variables ##
PROGRAM="stow"


## Main ##
# You have installed stow or not?
if [[ $(whereis ${PROGRAM} | grep -o "/bin/${PROGRAM}") == "/bin/${PROGRAM}" ]]; then
  printf "${PROGRAM} is installed in your system.\n"
else
  printf "${PROGRAM} is not installed in your system.\nPlease install ${PROGRAM} first.\n"
fi

# Link git configs
stow -v git

exit 0
