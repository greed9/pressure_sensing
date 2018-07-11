#!/bin/bash
#curl -H "X-AIO-Key: 6ae53a0570984238b46888bc806285fc" 'https://io.adafruit.com/api/groups/altitude-tracking/send.json?gps-altitude=435.039384&latitude=2841.330000&longitude=8130.919500&pressure-altitude=400'
curl -F 'value=65.5' -F 'lat=28.2990' -F 'lon=81.5000' -F 'ele=200' -H "X-AIO-Key: 6ae53a0570984238b46888bc806285fc" \
  https://io.adafruit.com/api/v2/SnoozeCat/feeds/pressure-altitude/data
