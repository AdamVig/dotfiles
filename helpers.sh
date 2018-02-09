#!/bin/bash

# Colorized output
# $1: string to print, must be quoted
# $2: optional, name of color, defaults to blue
message() {
    BLUE="\e[34m"
    DEFAULT="\e[0m"

    # Use color from $2 if provided, otherwise use blue
    if [ -z ${2+x} ]; then COLOR="$BLUE"; else COLOR="$2"; fi

    printf "$COLOR%s$DEFAULT\n" "$1"
}