#!/bin/bash

read -p "Enter a number: " num

if [ "$num" -eq 1 ]; then
  echo "All good ✅"
  exit 0   # success
elif [ "$num" -eq 2 ]; then
  echo "Minor issue ⚠️"
  exit 2   # custom warning
else
  echo "Major fail ❌"
  exit 5   # custom error
fi
