#!/bin/sh

for f in $(ls *.gz *.bz2 *.xz *.lz *.tgz)
do
  checksum=$(sha256sum $f | cut -d' ' -f1)
  echo ln -s $f ${f}_${checksum}
  ln -s $f ${f}_${checksum}
done
