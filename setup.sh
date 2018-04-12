#!/usr/bin/env bash

set -e 

brew tap caskroom/cask
brew cask install google-cloud-sdk

install_brew_package() {
  local brew_package=$1
  if [[ `which ${brew_package}` ]]; then
    echo "OK Found ${brew_package}!"
  else
    echo "INFO: Installing python 3"
    brew install ${brew_package}
  fi
}

install_brew_package terraform
install_brew_package python3

# login to gcloud. this will open up a browser. follow instructions on browser 
# gcloud auth application-default login

# Create virtual environment installing python dependencies
python3 -m venv .venv
source .venv/bin/activate
pip3 install -r ./app/app-engine-cron/requirements.txt
