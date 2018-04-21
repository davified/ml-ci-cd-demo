# Machine Learning CI/CD Pipeline Demo

### Getting started

1. Get into project directory: `cd ml-ci-cd`
2. In your terminal, run: `./setup.sh`
3. Activate the virtual environment: `source .venv/bin/activate`
4. Some manual configuration:
- generate credentials for GCP project [here](https://console.cloud.google.com/apis/credentials?project=ml-ci-ci-demo) -> select 'Service Account Key' -> enter details, select JSON and download it, and move/rename it to `~/.ssh/gcp_ml_ci_cd_demo.json`

### Updates for Ramsey (21-04-2018):
- Tasks/todos can be found at @ https://github.com/davified/ml-ci-cd-demo/projects/1
- GCP Project IAM - you've been added as a project owner to the ml-ci-cd-demo project. Once you accept the invitation via email you'd be able to provision/destroy resources on the project
- Bitcoin price service
  - every GET request to https://ml-ci-cd-demo.appspot.com/publish-bitcoin-price publishes a message to the [`bitcoin_stock_price` pub/sub topic](https://console.cloud.google.com/cloudpubsub/topics/bitcoin_stock_price?project=ml-ci-cd-demo)
  - 
- Bugs
  - I tried to create a dataflow pipeline: pubsub -> dataflow -> bigquery (using a [template](https://cloud.google.com/dataflow/docs/templates/provided-templates#cloudpubsubtobigquery)), but i keep getting the following error: `Unexpected character (',' (code 44)): Expected space separating root-level values` (click on the exclamation mark icon [here](https://console.cloud.google.com/dataflow/jobsDetail/locations/us-central1/jobs/2018-04-19_22_04_07-506590114544464195?project=ml-ci-cd-demo) to see the logs). I suspect there's something wrong with how my bitcoin service publishes the message (see `./app/bitcoin-app-engine-service/bitcoin_publisher.py#publish_messages()`). Here's a part of the error message

```
java.lang.RuntimeException: Unable to parse input
        com.google.cloud.teleport.templates.common.BigQueryConverters$JsonToTableRow$1.apply(BigQueryConverters.java:115)
        com.google.cloud.teleport.templates.common.BigQueryConverters$JsonToTableRow$1.apply(BigQueryConverters.java:104)
        org.apache.beam.sdk.transforms.Contextful.lambda$fn$79bf234f$1(Contextful.java:112)
        org.apache.beam.sdk.transforms.MapElements$1.processElement(MapElements.java:129)
Caused by: com.fasterxml.jackson.core.JsonParseException: Unexpected character (',' (code 44)): Expected space separating root-level values
 at [Source: 8,247.08; line: 1, column: 3]
```

### App

#### Bitcoin price publisher
- To deploy:
  - cd ./app/bitcoin-app-engine-service
  - ./deploy_app.sh
  - ./deploy_start_cron.sh
- endpoint: GET https://ml-ci-cd-demo.appspot.com/publish-bitcoin-price

### Infrastructure

#### Shell 

In `infrastructure/shell`, we keep a list of utility scripts. You need to `cd infrastructure/shell` before running the shell scripts

- Dataproc
  - To delete Dataproc cluster: `./delete_dataproc_cluster.sh <name of cluster>`
  - To create Dataproc cluster: `./create_dataproc_cluster.sh <name of cluster>`
  - To open Datalab notebook on the dataproc cluster: `./open_data_lab.sh`


### Notes/log of any manual steps
- Enable Google Cloud Resource Manager API by visiting: https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview?project=ml-ci-ci-demo
