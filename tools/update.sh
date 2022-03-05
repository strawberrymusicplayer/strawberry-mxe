#!/bin/sh

modified_files=$(git ls-files src/*.mk --modified || exit 1)
if [ "$modified_files" = "" ]; then
  exit 0
fi

for i in $modified_files; do
  package=$(grep '^PKG\s*:= ' $i | sed -e 's/^PKG\s*:= \(.*\)/\1/' || exit 1)
  if [ "$package" = "" ]; then
    continue
  fi
  git commit $i -m "Update $package" || exit 1
done

git push
