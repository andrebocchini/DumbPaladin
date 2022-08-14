#!/bin/sh

VERSION=$(grep "## Version" DumbPaladin/DumbPaladin.toc | awk '{split($0, a, ":"); print a[2]}' | sed 's/^[ ]*//')

if [ -z ${VERSION+x} ]; then
  echo "Missing version. Cannot create release."
  exit -1
fi

echo "Detected version: " $VERSION

zip -r DumbPaladin-${VERSION}.zip DumbPaladin