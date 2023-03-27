for d in purescript-*; do
  if [[ ! -d "$d" ]]; then
    continue
  fi
  git remote add "$d" git@github.com:purescript/$d.git
  git fetch "$d" master
done
