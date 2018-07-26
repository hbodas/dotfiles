
# when vim is called, it follows the symlinks to make sure that only one copy of
# the view and undo files are saved.
function vim() {
  args=()
  for i in $@; do
    if [[ -h $i ]]; then
      args+=`readlink $i`
    else
      args+=$i
    fi
  done

  /usr/bin/vim -p "${args[@]}"
}
