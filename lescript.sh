#!/bin/bash



# Est ce que in pas dans la liste de /tmp/
# Alors créer in/
if ! ls /tmp/ | grep in 1> /dev/null
  then
  cd /tmp/ ; mkdir in
fi

# Est ce que out pas dans la liste de /tmp/
# Alors créer out/
if ! ls /tmp/ | grep out 1> /dev/null
  then
  cd /tmp/ ; mkdir out
fi

if ! ls /tmp/out/ | grep lock /dev/null
  then
  # Création du fichier lock temporaire
  cd /tmp/out/ ; echo "locked" > lock

  # Ajout dans le log
  date >> /tmp/out/log
  ls /tmp/in/* >> /tmp/out/log

  ls /tmp/in/* | gzip > /tmp/out/tmpIn.gz
  echo "Les dossier de /tmp/in/ sont listé dans /tmp/out/tmpIn.gz"
  
  # Suppréssion du fichier lock temporaire
  cd /tmp/out/ ; rm lock
  exit 0
else
  echo "Le fichier /tmp/out/ est lock"
  exit 22
fi
