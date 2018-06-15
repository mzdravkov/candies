#!/bin/bash

help="Usage:\n\tPass the link to the youtube video with playlist as the first argument of the script (in quotes).\n\tThe second argument should be the range that will be downloaded (e.g. \"1-42\")\n\n\tExample:\n\t\t ./download-liked-playlist.sh \"https://www.youtube.com/watch?v=i3UfHUZ-2mE&list=LLK_AJ-uea4vBS3mVjHnVHXQ\" \"1-13\""


if [ $# -eq 0 ]
then
  echo -e $help
elif [ $1 == "--help" ]
then
  echo -e $help
else
  youtube-dl --yes-playlist --extract-audio --audio-format "mp3" -o '%(title)s.%(ext)s' --playlist-items $2 --embed-thumbnail $1
fi
