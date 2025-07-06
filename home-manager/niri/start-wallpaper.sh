#!/usr/bin/env bash
tries=5
delay=0.5

for i in $(seq 1 "$tries"); do
    if swww query &>/dev/null; then
        break
    fi
    sleep "$delay"
done

if ! swww query &>/dev/null; then
    total_time=$(awk "BEGIN {print $tries * $delay}")
    echo "swww-daemon not responding after ${total_time}s" >&2
    exit 1
fi

swww img ~/wallpapers/131029294_p2.jpg
