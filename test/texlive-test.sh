#!/usr/bin/env bash

# This file is used for testing this repo, replacing the corresponding .travis.yml which cannot be included.

cd ${TRAVIS_BUILD_DIR}/4-texlive/
source ${TRAVIS_BUILD_DIR}/4-texlive/texlive/texlive_install.sh

cd ${TRAVIS_BUILD_DIR}/src/
texliveonfly ./main.tex

texliveonfly ./biber-mwe.tex

texliveonfly fonts.tex --compiler=lualatex

texliveonfly --arguments='-shell-escape' ./minted.tex
