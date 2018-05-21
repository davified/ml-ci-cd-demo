#!/usr/bin/env bash

# set -e

if [[ $CI == "true" ]]; then
  anaconda_download_url="https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh"
else
  anaconda_download_url="https://repo.anaconda.com/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh"
fi

if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then 
  rm -rf $HOME/google-cloud-sdk
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1
  curl https://sdk.cloud.google.com | bash
# gcloud components update --version 175.0.0 # may need to set gcloud to v175 to get gsutil to work
fi
export PATH=$PATH:$HOME/google-cloud-sdk/bin/
export PATH=$HOME/anaconda3/bin:$PATH

if [[ `which conda` ]]; then
  echo "[INFO] OK Found conda!"
else
  if [[ ! -f "$HOME/anaconda3_installer/install.sh"  ]]; then
    echo "[INFO] Downloading anaconda installation script..."
    echo "[INFO] This is a 511MB file and will some time to complete..."
    echo "downloading 511mb file"
    mkdir -p $HOME/anaconda3_installer
    curl ${anaconda_download_url} -o "$HOME/anaconda3_installer/install.sh"
  fi

  echo "[INFO] Running anaconda installation script..."
  bash "$HOME/anaconda3_installer/install.sh" -b -p "$HOME/anaconda3"
fi

if [[ ! -d "$HOME/anaconda3/envs/${virtual_environment_name}" ]]; then
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
