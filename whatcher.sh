#!/bin/bash

# help command information
if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
  echo "Usage: whatcher [command]"
  echo "[command] support key, assets"
  echo "- key:  this command using for listen locale file or folder change default is assets/translations"
  echo "- assets: this command using for listen assets file or folder change default is assets/*"
  exit 0
fi

if [ -z "$1" ]
  then
    echo "No command supplied"
    exit 1
fi


if [ "$1" == "locale" ]
then
    nodemon --exec "./gen.sh locale" -w assets/languages -e "json"
elif [ "$1" == "assets" ]
then
    nodemon --exec "./gen.sh assets" -w assets -e "*"
else
    echo "Invalid command"
    exit 1
fi