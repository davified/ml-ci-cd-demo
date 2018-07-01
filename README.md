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

### Deployment

All models are deployed to GCP ML Engine. As training and deployment are time-consuming steps which we may not want to run with every commit, we've made training and deployment manual steps in our CI pipelines. 

As manual deployments is not a supported feature in TravisCI, we created a workaround to simulate manual deployments - by committing and push to 2 branches: `deploy-to-staging` and `deploy-to-prod`. To deploy to staging:
- merge all your changes onto the `deploy-to-staging` branch (by running `git checkout deploy-to-staging && git merge master`)
- push your changes (`git push origin deploy-to-staging`, or simply `git push`)

### Some manual configuration:

#### For collaborators on this project:
- generate credentials for GCP project [here](https://console.cloud.google.com/apis/credentials?project=ml-ci-ci-demo) -> select 'Service Account Key' -> enter details, select JSON and download it, and move/rename it to `./client_secret.json` (i.e. `ml-ci-cd-demo/client_secret.json`)

#### For collaborators on this project:
- [Sign up/sign in](https://console.cloud.google.com/) to your Google Cloud Platform account 
- Create a project on the [GCP console](https://console.cloud.google.com), and replace `PROJECT_ID` in `bin/common.sh` with your project name
- Generate `client_secret.json` credentials (see instructions in previous section)
- Click on these links and enable the following APIs:
  - [Cloud Resource Manager API](https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=ml-ci-ci-demo)
  - [ML Engine API](https://console.cloud.google.com/apis/api/ml.googleapis.com/overview)


### Resources
- [Tasks board](https://github.com/davified/ml-ci-cd-demo/projects/1)
- [CI](https://www.travis-ci.org/davified/ml-ci-cd-demo)
- [GCP project dashboard](https://console.cloud.google.com/home/dashboard?project=ml-ci-cd-demo)
- Demo client app
  - [Source](https://github.com/davified/ml-ci-cd-demo-react-client)
  - [Demo](https://pycon-ml-demo.herokuapp.com/)
- Server app
  - [Source](https://github.com/davified/ml-ci-cd-demo-express-server)
  - [Demo](https://ml-ci-cd-demo-server.herokuapp.com/)
