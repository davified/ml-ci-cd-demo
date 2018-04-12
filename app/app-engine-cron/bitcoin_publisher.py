import requests, datetime
from bs4 import BeautifulSoup
from google.cloud import pubsub

from constants import TOPIC_NAME, PROJECT_ID

def get_stock_price():
  url = 'https://sg.finance.yahoo.com/quote/BTC-USD/'
  page = requests.get(url)

  soup = BeautifulSoup(page.text, 'html.parser')
  current_stock_price_tag = soup.find(class_="Trsdu(0.3s) Trsdu(0.3s) Fw(b) Fz(36px) Mb(-4px) D(b)")

  try:
    current_stock_price = current_stock_price_tag.text
    print('current_stock_price: {}'.format(current_stock_price))
    return current_stock_price
  except Error:
    raise Exception('Bitcoin stock price not available')
  
def create_topic(project, topic_name):
  publisher = pubsub.PublisherClient()
  topic = 'projects/{project_id}/topics/{topic}'.format(
     project_id=project,
     topic=topic_name,
  )
  publisher.create_topic(topic) 

def publish_messages(project, topic_name, current_stock_price):
  publisher = pubsub.PublisherClient()
  topic_path = publisher.topic_path(project, topic_name)

  time_now = str(datetime.datetime.utcnow())
  
  data = u'bitcoin price'
  # Data must be a bytestring
  data = data.encode('utf-8')
  publisher.publish(topic_path, data=data, time=time_now, price=current_stock_price)

  print('Published message: {}'.format(data))
  
def delete_topic(project, topic_name):
  client = pubsub.PublisherClient()
  topic = client.topic_path(project, topic_name)
  client.delete_topic(topic)

publish_messages(PROJECT_ID, TOPIC_NAME, get_stock_price())