#!/usr/bin/env bash

docker run --mount src=$TRAVIS_BUILD_DIR/,target=/repo,type=bind phpirates/texlive-latexbuild:small-2018