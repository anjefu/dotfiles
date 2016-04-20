#!/bin/sh

set -e

DIR="projects/dotfiles"

for i in *; do
    if [ "$i" != "${0#./}" ]; then
        cd ../..
        ln -s -f ${DIR}/$i .$i
        cd ${DIR}
    fi
done
