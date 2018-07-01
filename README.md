# Machine Learning CI/CD Pipeline Demo

### Getting started

1. Clone repo: `git clone https://www.github.com/davified/ml-ci-cd-demo`
2. Setup dev environment: `bin/setup.sh`
3. To activate virtual environment: `source activate ml-ci-cd-demo` (To deactivate virtual environment: `source deactivate`)
4. Commands that you can run locally:
- `jupyter notebook` (start jupyter notebook for development)
- `bin/run_unit_tests.sh scikit-nlp-model`
- `bin/get_data.sh scikit-nlp-model`
- `bin/train.sh scikit-nlp-model`
- `bin/evaluate.sh scikit-nlp-model`
- `bin/smoke_test.sh MODEL_VERSION` (e.g. `bin/smoke_test.sh v2`)
5. Commands that are meant to be run by CI
- `bin/deploy_to_staging.sh`
- `bin/upload_artifact.sh`


### Some manual configuration:
For collaborators on this project
- generate credentials for GCP project [here](https://console.cloud.google.com/apis/credentials?project=ml-ci-ci-demo) -> select 'Service Account Key' -> enter details, select JSON and download it, and move/rename it to `./client_secret.json` (i.e. `ml-ci-cd-demo/client_secret.json`)


### Resources
- [Tasks board](https://github.com/davified/ml-ci-cd-demo/projects/1)
- [CI](https://www.travis-ci.org/davified/ml-ci-cd-demo)
- [GCP project dashboard](https://console.cloud.google.com/home/dashboard?project=ml-ci-cd-demo)


### Notes/log of any manual steps
- Enable Google Cloud Resource Manager API by visiting: https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=ml-ci-ci-demo


### Pros and Cons 

#### Travis-CI
- pros: easy to get started
- cons: no file-whitelisting functionality. Even updating a README triggers the CI pipeline (i.e. the training of a new model). (Work around for this: **commit and push to `deploy-to-prod` branch to "manually" trigger train and deploy stages on CI**)
