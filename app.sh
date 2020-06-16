#!/bin/bash

readonly projectid=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/project-id)

if result=$(gcloud compute instances list --project=$projectid --format='value(name)' 2>&1); then
  length=$(echo $result | wc -c)
  echo -e "HTTP/1.1 200 OK\nContent-Length: $length\n\n$result"
else
  length=$(echo $result | wc -c)
  echo -ne "HTTP/1.1 500 OK\nContent-Length: $length\n\n$result"
fi
