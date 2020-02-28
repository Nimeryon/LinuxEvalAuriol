#!/bin/bash

# Est ce que in pas dans la liste de /tmp/
# Alors créer in/
if ! ls /tmp/ | grep in
  then
  cd /tmp/ ; mkdir in
fi

# Est ce que out pas dans la liste de /tmp/
# Alors créer out/
if ! ls /tmp/ | grep out
  then
  cd /tmp/ ; mkdir out
fi

ls -a /tmp/in/ | gzip > /tmp/out/tmpIn.gz

exit 0
