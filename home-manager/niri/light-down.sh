#!/usr/bin/env bash

current=$(light -G | awk '{print int($1)}')

if (( current > 15 )); then
    light -U 5
elif (( current > 10 )); then
    light -S 10
else
    light -U 1
fi

