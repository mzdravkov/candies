#!/bin/bash


usage="$(basename "$0") [-h] [-s n] [-f n] [-i INPUT_BAM] [-1 OUTPUT1] [-2 OUTPUT2] \n\nSplits a BAM randomly into two files.

where:
    -h  show this help text
    -s  set the seed value (default: 42)
    -f  fraction of input to sample for output1. Only decimal part, e.g. 5 for 50%.
    -t  number of threads
    -i  path to the inupt bam
    -1  path to the first output bam
    -2  path to the second output bam"

seed=42
frac=5
threads=1

unset -v input
unset -v output1
unset -v output2


while getopts ':hsi:1:2:f:t::' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    s) seed=$OPTARG
       ;;
    i) input=$OPTARG
       ;;
    t) threads=$OPTARG
       ;;
    1) output1=$OPTARG
       ;;
    2) output2=$OPTARG
       ;;
    s) frac=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ -z "$input" ]; then
  echo 'Missing -i' >&2
  exit 1
fi
if [ -z "$output1" ]; then
  echo 'Missing option -1' >&2
  echo "$usage"
  exit 1
fi
if [ -z "$output2" ]; then
  echo 'Missing option -2' >&2
  echo "$usage"
  exit 1
fi


samtools view -t $threads -bo $output1 -s $seed.$frac $input
samtools view -t $threads $output1 | cut -f1 > ids.tmp
samtools view -t $threads -bo $output2 -N ^ids.tmp $input
rm ids.tmp

