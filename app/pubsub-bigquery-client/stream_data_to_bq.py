from googleapiclient.discovery import build
from oauth2client.client import GoogleCredentials

from constants import JOBNAME, TOPIC_NAME, BUCKET, TEMPLATE, SUBSCRIPTION_NAME, PROJECT, DATASET_NAME, TABLE_NAME

credentials = GoogleCredentials.get_application_default()
service = build('dataflow', 'v1b3', credentials=credentials)

GCSPATH="gs://{bucket}/templates/{template}".format(bucket=BUCKET, template=TEMPLATE),
BODY = {
		"jobName": "{jobname}".format(jobname=JOBNAME),
		"parameters": {
				"inputFile" : "gs://{bucket}/input/my_input.txt",
				"outputFile": "gs://{bucket}/output/my_output".format(bucket=BUCKET)
			},
			"environment": {
				"tempLocation": "gs://{bucket}/temp".format(bucket=BUCKET),
				"zone": "us-central1-f"
			}
}

request = service.projects().templates().launch(projectId=PROJECT, gcsPath=GCSPATH, body=BODY)
response = request.execute()

print(response)

# from pprint import pprint

# from google.cloud import pubsub
# from google.cloud import bigquery



# def stream_data_bigquery(counter):
# 	client = pubsub.SubscriberClient()
# 	topic = client.topic_path(PROJECT_ID, TOPIC_NAME)
# 	subscriber = pubsub.SubscriberClient()
# 	subscription_path = subscriber.subscription_path(
#         PROJECT_ID, SUBSCRIPTION_NAME)

# 	bigquery_client = bigquery.Client()
# 	dataset = bigquery_client.dataset(DATASET_NAME)
# 	table = dataset.table(TABLE_NAME)

# 	batch = []
# 	i = 0

# 	table.reload()
# 	errors = table.insert_data([data])
# 	if not errors:
# 		print('Loaded 1 row into {}:{}'.format(dataset_name, table_name))
# 	else:
# 		print('Errors:')
# 		pprint(errors)

# stream_data_bigquery(10)