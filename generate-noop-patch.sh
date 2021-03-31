#!/bin/bash

set -exuo pipefail

version="${1:?Specify base version for the patch, ex: 7.4.7}"

rm patch.zip
cd patch
mkdir -p META-INF misc
sed -i "s/7\.4\.6/$version/g" patch.xml
zip ../patch.zip *
