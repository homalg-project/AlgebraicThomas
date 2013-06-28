#!/bin/sh

## this script must be executed in AlgebraicThomas subdirectory

if [ -d ./AlgebraicThomas ]; then
    cd ./AlgebraicThomas
    git pull --ff-only
else
    git clone git+ssh://barakat@bob.math.rwth-aachen.de/home/thomas/misc/git/AlgebraicThomas.git
fi
