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
  grep '^\$(PKG)_CHECKSUM :=\s$' $i >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Skipping $i, invalid checksum."
    git checkout $i
    continue
  fi
  echo "Committing $i"
  git commit $i -m "Update $package" || exit 1
done

git push
