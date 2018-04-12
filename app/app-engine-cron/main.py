import logging

from flask import Flask
import bitcoin_publisher

app = Flask(__name__)

@app.route('/publish-bitcoin-price')
def get_stock_price():
  price = bitcoin_publisher.get_stock_price()
  bitcoin_publisher.publish_messages('tw-data-engineering-demo', 'bitcoin-stock-price', price) # publish message
  return 'bitcoin price: {}'.format(price)

@app.errorhandler(500)
def server_error(e):
    logging.exception('An error occurred during a request.')
    return """
    An internal error occurred: <pre>{}</pre>
    See logs for full stacktrace.
    """.format(e), 500


if __name__ == '__main__':
    # This is used when running locally. Gunicorn is used to run the
    # application on Google App Engine. See entrypoint in app.yaml.
    app.run(host='127.0.0.1', port=8080, debug=True)
