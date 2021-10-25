#!/bin/bash


# Create a project and set GKE_PROJECT to the project id:
# See https://console.cloud.google.com/projectselector2/home/dashboard

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

# Create a GKE cluster
gcloud container clusters create $GKE_CLUSTER --num-nodes=1

# Configure kubctl
gcloud container clusters get-credentials $GKE_CLUSTER

# Should still be empty
kubectl get pods

# enable API
gcloud services enable \
	containerregistry.googleapis.com \
	container.googleapis.com

# Create a service account
gcloud iam service-accounts create $GKE_SERVICE \
    --display-name "GitHub Deployment" \
    --description "Used to deploy from GitHub Actions to GKE"

# Get mail of service account
gcloud iam service-accounts list

GKE_SVC_MAIL="$GKE_SERVICE@$GKE_PROJECT.iam.gserviceaccount.com"

# Add roles:
gcloud projects add-iam-policy-binding $GKE_PROJECT \
  --member=serviceAccount:$GKE_SVC_MAIL \
  --role=roles/container.admin \
  --role=roles/storage.admin \
  --role=roles/container.clusterViewer

# Download JSON
gcloud iam service-accounts keys create key.json --iam-account=$GKE_SVC_MAIL

# Activate service account
gcloud auth activate-service-account --key-file key.json

export GKE_SA_KEY=$(cat key.json | base64)

echo ""
echo "Please create a secret named 'GKE_SA_KEY' in GitHub with the followign content:"
echo ""
cat key.json | base64
echo ""