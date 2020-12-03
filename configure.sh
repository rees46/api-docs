#!/bin/bash

if [ "$1" = 'pc' ]; then
  cp config.pc.rb config.rb
elif [ "$1" = 'r46' ]; then
  cp config.r46.rb config.rb
elif [ "$1" = 'kameleoon' ]; then
  cp config.kameleoon.rb config.rb
else
  echo "Please set WL code as the first param"
  exit 1;
fi
