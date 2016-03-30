#!/bin/bash

help="Usage:\n\tGo to liked videos page in youtube, click 'show more' to see all videos\n\tthat you want to download and save the page as html file.\n\tPass this file as the first argument to this script."
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
  cat $1 \
    | sed -n -e 's/.*href="\(https:\/\/www\.youtube\.com\/watch[^"]*\)".*/\1/p' \
    | uniq \
    | xargs -I % youtube-dl --extract-audio --audio-format "mp3" % || true
fi
