#!/bin/bash

help="Usage:\n\tPass the link to the youtube video with playlist as the first argument of the script.\n\tAny additional flags can be passed after that."
if [ $# -eq 0 ]
then
  echo -e $help
elif [ $1 == "--help" ]
then
  echo -e $help
else
  if ! youtube_dl_loc="$(type -p youtube-dl)" || [ -z "$youtube_dl_loc" ]; then
    echo "youtube-dl is not installed on your system. Will attempt to install it now..."
    echo "If you don't trust this program, you can interupt it and install the youtube-dl with:"
    echo -e "\t sudo pip install --upgrade youtube_dl"
    echo "Then run this program again."
    read -r -p "Do you want to install youtube-dl automatically now? [y/N] " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
      sudo pip install --upgrade youtube_dl
    else
      exit 0
    fi
  fi
  youtube-dl --yes-playlist --extract-audio --audio-format "mp3" $1
fi
