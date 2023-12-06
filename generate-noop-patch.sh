#!/bin/bash

set -exuo pipefail

version="7.6.6-patch"

rm patch.zip
cd patch
mkdir -p META-INF misc
sed -i "s/7\.4\.6/$version/g" patch.xml
zip ../patch.zip *
