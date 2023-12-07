#!/bin/bash

set -exuo pipefail

version="${1:?Specify base version for the patch, ex: 7.6.6}"

rm patch.zip
cd patch
mkdir -p META-INF misc
sed -i "s/7\.6\.6/$version/g" patch.xml
zip ../patch.zip *
