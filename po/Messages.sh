#!/bin/bash
PROJECT="drakmenustyle"

echo "Merging translations"

catalogs=`find . -name '*.po'`

for cat in $catalogs; do
  echo $cat
  msgmerge -o $cat.new $cat ${PROJECT}.pot
  mv $cat.new $cat
done

echo "Done merging translations"
