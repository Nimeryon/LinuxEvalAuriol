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

if ! ls /tmp/out/ | grep lock 1> /dev/null
  then
  # Création du fichier lock temporaire
  cd /tmp/out/ ; echo "locked" > lock

  if ! [ "$(ls -A /tmp/in/)" ]
    then
    date >> /tmp/out/log
    echo "Erreur : aucun fichier n'as était trouvé dans /tmp/in/" >> /tmp/out/log  
    echo "Erreur : aucun fichier n'as était trouvé dans /tmp/in/"
    exit 2
  fi

  # Ajout dans le log
  date >> /tmp/out/log
  ls -A /tmp/in/* >> /tmp/out/log

  if ! (gzip -r /tmp/in/* ; mv /tmp/in/* /tmp/out/ 2> /dev/null)
    then
    echo "Un problême est survenue lors de la compréssion ou du transfert" >> /tmp/out/log
    echo "Un problème est survenue lors de la compréssion ou du transfert"
    exit 2
  fi

  echo "Les dossier de /tmp/in/ ont étais compréssé puis envoyé dans /tmp/out/tmpIn.gz"
  
  # Suppréssion du fichier lock temporaire
  cd /tmp/out/ ; rm lock
  exit 0
else
  echo "Le fichier /tmp/out/ est lock"
  exit 22
fi
