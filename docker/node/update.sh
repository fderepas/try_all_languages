#!/bin/sh
set -e
scriptName=`basename $0`
cd `dirname $0`
lang=$(basename `pwd`)
npm install jsdom
s=`node look_html.js`
d=`bash version.sh`
if [ "$s" != "$d" ]; then
    echo updating $lang
    make
    cd ..
    make version.json
    cd ..
    git commit . -m "auto update $lang"
    git push
    cd services/generic_machine/cmd/scripts/
    bash update_and_push_image.sh -l $lang
fi
