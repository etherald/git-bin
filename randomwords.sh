#!/bin/sh
for i in $@
do
    shuf /usr/share/dict/words.pre-dictionaries-common | head -n $i
done
