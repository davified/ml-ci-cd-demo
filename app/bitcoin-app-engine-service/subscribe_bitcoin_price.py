import os, time
from google.cloud import pubsub
from constants import SUBSCRIPTION_NAME, TOPIC_NAME, PROJECT_ID

def create_subscription(project_id, topic_name, subscription_name):
    client = pubsub.SubscriberClient()
    name = client.subscription_path(project_id, subscription_name)
    topic = client.topic_path(project_id, topic_name)

    response = client.create_subscription(name, topic)

def receive_messages(project, subscription_name):
    """Receives messages from a pull subscription."""
    subscriber = pubsub.SubscriberClient()
    subscription_path = subscriber.subscription_path(
        project, subscription_name)

    def callback(message):
        print('Received message: {}'.format(message))
        message.ack()

    subscriber.subscribe(subscription_path, callback=callback)

    # The subscriber is non-blocking, so we must keep the main thread from
    # exiting to allow it to process messages in the background.
    print('Listening for messages on {}'.format(subscription_path))
    while True:
        time.sleep(60)

def delete_subscription(project, subscription_name):
    client = pubsub.SubscriberClient()
    subscription = client.subscription_path(project, subscription_name)
    client.delete_subscription(subscription)

# create_subscription(PROJECT_ID, TOPIC_NAME, SUBSCRIPTION_NAME)
receive_messages(PROJECT_ID, SUBSCRIPTION_NAME)
