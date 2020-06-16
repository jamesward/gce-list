#!/bin/bash

readonly projectid=$(curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/project-id)

readonly result=$(gcloud compute instances list --project=$projectid --format='value(name)' 2>&1)
echo -e "HTTP/1.0 200 OK\n\ninstances:\n$result"
