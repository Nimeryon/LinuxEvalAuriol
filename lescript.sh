#!/bin/bash

# Est ce que in pas dans la liste de /tmp/
# Alors créer in/
if ! [ -d /tmp/in/ ]
  then
  mkdir /tmp/in
fi

# Est ce que out pas dans la liste de /tmp/
# Alors créer out/
if ! [ -d /tmp/out/ ]
  then
  mkdir /tmp/out
fi

if ! [ -e /tmp/out/lock ]
  then
  # Création du fichier lock temporaire
  touch /tmp/out/lock
  # Ajout de la date dans le log
  date >> /tmp/out/log

  if ! [ "$(ls -A /tmp/in/)" ]
    then
    echo "Erreur : aucun fichier n'as était trouvé dans /tmp/in/" >> /tmp/out/log  
    rm /tmp/out/lock
    exit 2
  fi
  
  for fichier in $(ls /tmp/in/)
    do
    if gzip /tmp/in/$fichier 2> /dev/null 
      then
      mv /tmp/in/$fichier.gz /tmp/out/
      echo "Le fichier $fichier à étais compréssé et envoyé dans le dossier /tmp/out/" >> /tmp/out/log
    else
      echo "Une erreur est survenue avec le fichier $fichier" >> /tmp/out/log
    fi
  done
  
  # Suppréssion du fichier lock temporaire
  rm /tmp/out/lock
  exit 0
else
  echo "Le fichier /tmp/out/ est lock"
  exit 22
fi
