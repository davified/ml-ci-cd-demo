# Machine Learning CI/CD Pipeline Demo

### Getting started

1. Get into project directory: `cd ml-ci-cd`
2. Build docker image: `docker build -t ml-ci-cd-demo .`
3. Start docker image: `docker run -p 8888:8888 -ti -v $(pwd):/app ml-ci-cd-demo bash`
4. Some manual configuration:
- generate credentials for GCP project [here](https://console.cloud.google.com/apis/credentials?project=ml-ci-ci-demo) -> select 'Service Account Key' -> enter details, select JSON and download it, and move/rename it to `~/.ssh/gcp_ml_ci_cd_demo.json`,
- Update `./infrastructure/shell/configure_api_key.sh` with the path to your 
- To start `jupyter notebook`, run this inside the docker container: `jupyter notebook --ip 0.0.0.0 --no-browser`

### Infrastructure

#### Shell 

In `infrastructure/shell`, we keep a list of utility scripts. You need to `cd infrastructure/shell` before running the shell scripts

- Dataproc
  - To delete Dataproc cluster: `./delete_dataproc_cluster.sh <name of cluster>`
  - To create Dataproc cluster: `./create_dataproc_cluster.sh <name of cluster>`
  - To open Datalab notebook on the dataproc cluster: `./open_data_lab.sh`


### Notes/log of any manual steps
- Enable Google Cloud Resource Manager API by visiting: https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=ml-ci-ci-demo
