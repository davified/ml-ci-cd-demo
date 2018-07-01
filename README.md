# Machine Learning CI/CD Pipeline Demo

### Resources
- [Tasks board](https://github.com/davified/ml-ci-cd-demo/projects/1)
- [CI](https://www.travis-ci.org/davified/ml-ci-cd-demo)
- [GCP project dashboard](https://console.cloud.google.com/home/dashboard?project=ml-ci-cd-demo)

### Getting started

1. Get into project directory: `cd ml-ci-cd-demo`
2. Setup dev environment: `bin/setup.sh`
3. Some manual configuration:
- generate credentials for GCP project [here](https://console.cloud.google.com/apis/credentials?project=ml-ci-ci-demo) -> select 'Service Account Key' -> enter details, select JSON and download it, and move/rename it to `./client_secret.json` (i.e. `ml-ci-cd-demo/client_secret.json`)
4. To activate virtual environment: `source activate ml-ci-cd-demo`
5. To deactivate virtual environment: `source deactivate`
6. Commands that you can run locally
- `bin/train_locally.sh`
- `bin/evaluate.sh`
- `bin/predict.sh`
- `bin/smoke_test.sh`
- `jupyter notebook` (start jupyter notebook for development)

7. Commands that are meant to be run by CI (If you want to run these locally, prefix it with `CI=true` (e.g. CI=true bin/deploy_to_staging.sh))
- `bin/deploy_to_staging.sh`
- `bin/upload_artifact.sh`


### Notes/log of any manual steps
- Enable Google Cloud Resource Manager API by visiting: https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=ml-ci-ci-demo


### Pros and Cons 

#### Travis-CI
- pros: easy to get started
- cons: no file-whitelisting functionality. Even updating a README triggers the CI pipeline (i.e. the training of a new model). (Work around for this: **commit and push to `deploy-to-prod` branch to "manually" trigger train and deploy stages on CI**)
