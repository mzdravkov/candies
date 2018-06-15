#!/bin/bash

help="Usage:\n\tPass the link to the youtube video with playlist as the first argument of the script.\n\tThe second argument should be the range that will be downloaded (e.g. 1-42)\n\tAny additional flags can be passed after that."


if [ $# -eq 0 ]
then
  echo -e $help
elif [ $1 == "--help" ]
then
  echo -e $help
else
  youtube-dl --yes-playlist --extract-audio --audio-format "mp3" -o '%(title)s.%(ext)s' --playlist-items 1-14 --embed-thumbnail $1 $2
fi
