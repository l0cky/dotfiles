#!/usr/bin/env bash

base_dir=$(pwd)

echo "$base_dir, $HOME"

# Konfig fájlpárok meghatározása, honnan, hova
declare -A links=(\
  ["bash/bash_aliases"]=".bash_aliases"\
  ["git/gitconfig"]=".gitconfig"\
  ["git/gitignore_global"]=".gitignore_global"\
  ["tmux/tmux/"]=".tmux/"\
  ["tmux/tmux.conf"]=".tmux.conf"\
  ["vim/vimrc"]=".vimrc"\
  ["bin/extvga"]="bin/extvga"\
  )

# A konfig fájlok linkelése
for conf in "${!links[@]}"; do
  echo "Create link: $conf -> ${links["$conf"]}";
  ln -sf ${base_dir}/$conf ${HOME}/${links["$conf"]};
done

# Sor hozzáadása funkció
append_line() {
  set -e

  local skip line file pat lno
  skip="$1"
  line="$2"
  file="$3"
  pat="${4:-}"

  echo "Update $file:"
  echo "  - $line"
  [ -f "$file" ] || touch "$file"
  if [ $# -lt 4 ]; then
    lno=$(\grep -nF "$line" "$file" | sed 's/:.*//' | tr '\n' ' ')
  else
    lno=$(\grep -nF "$pat" "$file" | sed 's/:.*//' | tr '\n' ' ')
  fi
  if [ -n "$lno" ]; then
    echo "    - Already exists: line #$lno"
  else
    if [ $skip -eq 1 ]; then
      echo >> "$file"
      echo "$line" >> "$file"
      echo "    + Added"
    else
      echo "    ~ Skipped"
    fi
  fi
  echo
  set +e
}

update_config=1
dest=~/.bashrc
append_line $update_config "[ -f ~/.local/dotfiles/bash/bash_extras ] && source ~/.local/dotfiles/bash/bash_extras" "$dest" "~/.local/dotfiles/bash/bash_extras"

exit 0
