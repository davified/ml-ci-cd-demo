#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="${current_directory}/.."
export IS_SETUP='true'
source ${current_directory}/common.sh

if [[ $CI == "true" ]]; then
  miniconda_download_url="https://repo.anaconda.com/miniconda/Miniconda3-4.5.1-Linux-x86_64.sh"
else
  miniconda_download_url="https://repo.anaconda.com/miniconda/Miniconda3-4.5.1-MacOSX-x86_64.sh"
fi

if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then 
  rm -rf $HOME/google-cloud-sdk
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1
  curl https://sdk.cloud.google.com | bash
fi
export PATH=$HOME/google-cloud-sdk/bin:$HOME/miniconda3/bin:$PATH

if [[ -f $HOME/miniconda3/bin/conda ]]; then
  echo "[INFO] OK Found conda!"
else
  if [[ ! -f "$HOME/miniconda3_installer/install.sh"  ]]; then
    echo "[INFO] Downloading miniconda installation script..."
    mkdir -p $HOME/miniconda3_installer
    curl ${miniconda_download_url} -o "$HOME/miniconda3_installer/install.sh"
  fi

  echo "[INFO] Running miniconda installation script..."
  bash "$HOME/miniconda3_installer/install.sh" -u -b -p "$HOME/miniconda3"
fi

if [[ ! -d "$HOME/miniconda3/envs/${virtual_environment_name}" ]]; then
  echo "[INFO] Creating ${virtual_environment_name} virtual environment and installing dependencies..."
  conda env create -f ${project_directory}/environment.yml
else 
  if [[ $CI == '' ]]; then
    echo "[INFO] Updating dependencies..."
    conda env update # run this only locally to speed up build times
  fi
fi

if [[ $CI != 'true' ]]; then
  source deactivate
  source activate ${virtual_environment_name}
  python -m ipykernel install --user --name ${virtual_environment_name} --display-name "${virtual_environment_name}"
fi

echo "[INFO] Done!"
echo "[INFO] To activate the virtual environment, run: source activate ${virtual_environment_name}"
echo "[INFO] To deactivate the virtual environment, run: source deactivate"
