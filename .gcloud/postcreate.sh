#!/bin/bash

set -x

declare project=$GOOGLE_CLOUD_PROJECT
declare service=$K_SERVICE
declare region=$GOOGLE_CLOUD_REGION

declare sa=gce-list@$project.iam.gserviceaccount.com

gcloud iam service-accounts describe $sa --project $project &> /dev/null

if [ $? -ne 0 ]; then
  echo "creating service account: $sa"
  gcloud iam service-accounts create gce-list \
    --display-name="$service" \
    --project=$project &> /dev/null

  echo "gonna wait 30 seconds for iam consistency"
  sleep 30
fi

echo "allowing $sa to list GCE instances"
gcloud projects add-iam-policy-binding $project \
  --member=serviceAccount:$sa \
  --role=roles/compute.viewer &> /dev/null

echo "allowing $sa to be a serviceAccountUser"
gcloud projects add-iam-policy-binding $project \
  --member=serviceAccount:$sa \
  --role=roles/iam.serviceAccountUser &> /dev/null

echo "updating $service to use the service account $sa"
gcloud run services update $service \
  --platform=managed --project=$project --region=$region \
  --service-account=$sa &> /dev/null

