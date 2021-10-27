#!/bin/bash

# Set parameters
GKE_PROJECT=valid-octagon-330106
GKE_CLUSTER=xyz-demo-cluster
GKE_SERVICE_ACCOUNT=xyz-serviceaccount
GKE_REGION=europe-west3

gcloud config set project $GKE_PROJECT

# Delete the cluster
gcloud container clusters delete $GKE_CLUSTER

# Delete service account
gcloud iam service-accounts delete "$GKE_SERVICE_ACCOUNT@$GKE_PROJECT.iam.gserviceaccount.com"

# Delete repository
gcloud artifacts repositories delete $GKE_PROJECT --location $GKE_REGION