#!/bin/bash

service td-agent start
service elasticsearch start
service kibana start
service nginx start

echo -n 'Wait for launch elasticsearch'
while true; do
  if [ $(curl http://localhost:9200/ -o /dev/null -w '%{http_code}' -s) = "200" ]; then
    echo ' OK'
    break;
  fi
  echo -n '.'
  sleep 1
done

echo "elasticsearch information"
curl "http://localhost:9200/"

# Create an index
# curl -X PUT "http://localhost:9200/nginx" -s -o /dev/null

tail -f /var/log/td-agent/td-agent.log
