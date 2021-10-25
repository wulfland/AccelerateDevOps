#!/bin/bash


# Create a project:
https://console.cloud.google.com/projectselector2/home/dashboard

# Set parameters
GKE_PROJECT=gke-demo
GKE_CLUSTER=xyz-demo-shop-cluster
GKE_SERVICE=xyz-service

# https://cloud.google.com/compute/docs/regions-zones#available
GKE_ZONE=europe-west3-a

gcloud config set project $GKE_PROJECT
gcloud config set compute/zone $GKE_ZONE
gcloud config set compute/region $GKE_ZONE

# Create a GKE cluster
gcloud container clusters create $GKE_CLUSTER --num-nodes=1

# enable API
gcloud services enable \
	containerregistry.googleapis.com \
	container.googleapis.com

# Create a service account
gcloud iam service-accounts create $GKE_SERVICE \
    --display-name "GitHub Deployment"
    --description "Used to deploy from GitHub Actions to GKE"

# Get mail of service account
gcloud iam service-accounts list

GKE_SVC_MAIL=$GKE_SERVICE@$GKE_PROJECT.iam.gserviceaccount.com

# Add roles:
gcloud projects add-iam-policy-binding $GKE_PROJECT \
  --member=serviceAccount:$GKE_SVC_MAIL \
  --role=roles/container.admin \
  --role=roles/storage.admin \
  --role=roles/container.clusterViewer

# Download JSON
gcloud iam service-accounts keys create key.json --iam-account=$GKE_SVC_MAIL

export GKE_SA_KEY=$(cat key.json | base64)

echo "Please create a secret named 'GKE_SA_KEY' in GitHub with the followign content:"
echo ""
echo $GKE_SA_KEY