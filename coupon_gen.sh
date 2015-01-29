#! /bin/sh
 /usr/bin/pwgen -10A  10 | /usr/bin/awk '{print toupper($0)}'