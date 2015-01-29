#!/bin/sh
for i in $@
do
    shuf /usr/share/dict/words | head -n $i
done
