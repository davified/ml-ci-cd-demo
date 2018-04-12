# Machine Learning CI/CD Pipeline Demo

### Getting started

1. Get into proejct directory: `cd ml-ci-cd`
2. In your terminal, run: `./setup.sh`
3. Activate the virtual environment: `source .venv/bin/activate`
4. Start coding!

### App



### Infrastructure

- create credentials [here](https://console.cloud.google.com/apis/credentials?project=ml-ci-ci-demo) -> select 'Service Account Key' -> enter details, select JSON and download it to `./infrastructure/secrets/gcp_credentials.json`
- Enable Google Cloud Resource Manager API by visiting: https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=ml-ci-ci-demo

#### Shell 

In `infrastructure/shell`, we keep a list of utility scripts. You need to `cd infrastructure/shell` before running the shell scripts

- Dataproc
  - To delete Dataproc cluster: `./delete_dataproc_cluster.sh <name of cluster>`
  - To create Dataproc cluster: `./create_dataproc_cluster.sh <name of cluster>`
  - To open Datalab notebook on the dataproc cluster: `./open_data_lab.sh`
