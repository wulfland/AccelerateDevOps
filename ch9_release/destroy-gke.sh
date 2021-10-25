#!/bin/bash

# Set parameters
GKE_PROJECT=gke-demo
GKE_CLUSTER=xyz-demo-shop-cluster

# https://cloud.google.com/compute/docs/regions-zones#available
GKE_ZONE=europe-west3-a

gcloud config set project $GKE_PROJECT
gcloud config set compute/zone $GKE_ZONE
gcloud config set compute/region $GKE_ZONE

# Delete the cluster
gcloud container clusters delete $GKE_CLUSTER