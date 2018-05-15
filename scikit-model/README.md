# Deploying scikit-learn models on ML engine

### Getting started
- Clone repository
- build python 3.5.0 dev environment: `docker build -t sklearn-ml-engine .`
- start dev environment: `docker run -ti -v $(pwd):/app sklearn-ml-engine bash`

### Commands

#### in docker container
- Train model: run `python train.py` 

#### outside docker container (i.e. in your regular shell)
- Deploy model: run `./deploy.sh`
- Get predictions from model: run `./predict.sh`
  - You can also make a request from insomnia

TODO: davidtan [2018-04-29]: Add gcloud installation / gcloud ssh keys config instructions