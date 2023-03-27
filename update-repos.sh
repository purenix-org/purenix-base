for d in purescript-*; do
  if [[ ! -d "$d" ]]; then
    continue
  fi
  echo "$d"
  pushd "$d"
  git diff "HEAD:./src" "$d/master:src" --diff-filter=AMCRTUX >"../$d-src.patch"
  git diff "HEAD:./test" "$d/master:test" --diff-filter=AMCRTUX >"../$d-test.patch"
  git diff "HEAD:./CHANGELOG.md" "$d/master:CHANGELOG.md" >"../$d-CHANGELOG.patch"
  sed -e "s|a/$d|a|" -i "../$d-CHANGELOG.patch"
  popd
  git apply --verbose --no-index --directory "$d/src" <"$d-src.patch"
  git apply --verbose --no-index --directory "$d/test" <"$d-test.patch"
  git apply --verbose --no-index --directory "$d" <"$d-CHANGELOG.patch"
done
