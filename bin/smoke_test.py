import googleapiclient.discovery
import argparse

parser = argparse.ArgumentParser('smoke_test.py')
parser.add_argument('--version', required=True)

args = vars(parser.parse_args())

VERSION_NAME = '{}'.format(args['version'])
PROJECT_ID = 'ml-ci-cd-demo'
MODEL_NAME = 'nlp_sentiment'

service = googleapiclient.discovery.build('ml', 'v1')
name = 'projects/{}/models/{}'.format(PROJECT_ID, MODEL_NAME)
name += '/versions/{}'.format(VERSION_NAME)

complete_results = []
responses = service.projects().predict(
  name=name,
  body={'instances': [
    "hello this is a smoke test!",
    "hello this is another smoke test!"
  ]}
).execute()

if 'error' in responses:
  print(responses['error'])
  exit(1)
else:
  complete_results.extend(responses['predictions'])
        
# Print the first 10 responses
for i, response in enumerate(complete_results[:10]):
  print('Prediction: {}'.format(response))