#!/usr/bin/env bash

set -e

virtual_environment_name="ml-ci-cd-demo"

if [[ $OSTYPE != "darwin"* ]]; then
  echo "[INFO] Non-Mac OSX operating system detected"
  echo "[TODO] Open http://continuum.io/downloads with your web browser"
  echo "[TODO] Download the Python 3 installer for your OS"
  echo "[TODO] Install Python 3 using all of the defaults for installation, except make sure to check 'Make Anaconda the default Python'"
  echo "[INFO] Exiting..."
  exit 0
fi

if [[ `which gcloud` ]]; then
  echo "[INFO] OK found gcloud"
  echo "Setting gcloud components version to 175.0.0"
  # gcloud components update --version 175.0.0
else
  brew tap caskroom/cask
  brew cask install google-cloud-sdk

  # gcloud components update --version 175.0.0
fi

# TODO: davidtan [2018-05-17] should we check and install specific version of conda? or will conda update conda do that?
if [[ `which conda` ]]; then
  echo "[INFO] OK Found conda!"
else
  if [[ ! -f ./anaconda3.sh  ]]; then
    echo "[INFO] Downloading anaconda installation script..."
    echo "[INFO] This is a 511MB file and will some time to complete..."
    echo "downloading 511mb file"
    curl https://repo.anaconda.com/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh -o ./anaconda3.sh
  fi

  echo "[INFO] Running anaconda installation script..."
  bash anaconda3.sh -b -p ~/anaconda3
fi

export PATH="$HOME/anaconda3/bin:$PATH"

if [[ ! -d "${HOME}/anaconda3/envs/${virtual_environment_name}" ]]; then
  echo "[INFO] Creating ${virtual_environment_name} virtual environment and installing dependencies..."
  conda env create -f ./environment.yml
else 
  echo "[INFO] Installing dependencies..."
  conda env update
fi

source activate ${virtual_environment_name}
python -m ipykernel install --user --name ${virtual_environment_name} --display-name "${virtual_environment_name}"

echo "[INFO] Done!"
echo "[INFO] To activate the virtual environment, run: source activate ${virtual_environment_name}"
echo "[INFO] To deactivate the virtual environment, run: source deactivate"
