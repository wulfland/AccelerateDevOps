#!/bin/bash

# Set parameters
GKE_PROJECT=valid-octagon-330106
GKE_CLUSTER=xyz-demo-cluster
GKE_SERVICE=xyz-service-account

# gcloud compute zones list
GKE_ZONE=europe-west3-a

# gcloud compute regions list
GKE_REGION=europe-west3

gcloud config set project $GKE_PROJECT
gcloud config set compute/zone $GKE_ZONE
gcloud config set compute/region $GKE_REGION

# Delete the cluster
gcloud container clusters delete $GKE_CLUSTER

# Delete service account
gcloud iam service-accounts delete "$GKE_SERVICE@$GKE_PROJECT.iam.gserviceaccount.com"