#!/bin/sh
watch -n 5 -d "ls -l $@ && tail $@"
