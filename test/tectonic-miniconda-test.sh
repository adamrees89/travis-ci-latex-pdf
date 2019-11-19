#!/usr/bin/env bash

# Copied from 2-tectonic-miniconda/.travis.yml without comments
sudo apt-get install texlive-binaries
export PATH="$HOME/miniconda/bin:$PATH"
if ! command -v conda > /dev/null; then
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
  bash miniconda.sh -b -p $HOME/miniconda -u;
  conda config --add channels conda-forge;
  conda config --set always_yes yes;
  conda install tectonic==0.1.11;
fi
conda install -c malramsay biber==2.11 --yes
conda info -a

# Workaround until tectonic 0.1.11 is available
#sudo mkdir -p ~/.config/Tectonic/
#echo "[[default_bundles]]" | sudo tee --append ~/.config/Tectonic/config.toml
#sudo echo "url = \"https://tectonic.newton.cx/bundles/tlextras-2018.1r0/bundle.tar\"" | sudo tee --append ~/.config/Tectonic/config.toml

cd ${TRAVIS_BUILD_DIR}/src/
tectonic --keep-intermediates --reruns 0 ./main.tex
tectonic --keep-intermediates --reruns 0 ./biber-mwe.tex
if [ -f "biber-mwe.bcf" ]; then biber biber-mwe; fi
tectonic --keep-intermediates ./biber-mwe.tex
#makeindex ./main.idx