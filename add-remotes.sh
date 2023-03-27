for d in purescript-*; do
  git remote add "$d" git@github.com:purescript/$d.git
  git fetch "$d" master --depth 1
done
