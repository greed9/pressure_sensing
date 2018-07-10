# Import library and create instance of REST client.
from Adafruit_IO import Client
aio = Client('6ae53a0570984238b46888bc806285fc')

# Get feed 'Foo'
feed = aio.feeds('pressure-altitude')

# Print out the feed metadata.
print(feed)
