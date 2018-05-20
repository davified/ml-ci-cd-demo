import googleapiclient.discovery

PROJECT_ID = 'ml-ci-cd-demo'
VERSION_NAME = 'v4'
MODEL_NAME = 'census_sklearn_pipeline'

service = googleapiclient.discovery.build('ml', 'v1')
name = 'projects/{}/models/{}'.format(PROJECT_ID, MODEL_NAME)
name += '/versions/{}'.format(VERSION_NAME)

complete_results = []
responses = service.projects().predict(
    name=name,
    body={'instances': [
      [25, 'Private', 226802, '11th', 7, 'Never-married', 'Machine-op-inspct', 'Own-child', 'Black', 'Male', 0, 0, 40, 'United-States'],
      [44, 'Private', 160323, 'Some-college', 10, 'Married-civ-spouse', 'Machine-op-inspct', 'Husband', 'Black', 'Male', 7688, 0, 40, 'United-States']
    ]}
).execute()

if 'error' in responses:
    print(responses['error'])
else:
    complete_results.extend(responses['predictions'])
        
# Print the first 10 responses
for i, response in enumerate(complete_results[:10]):
    print('Prediction: {}'.format(response))