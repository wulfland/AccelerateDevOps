#!/bin/bash


# Create a project and set GKE_PROJECT to the project id:
# See https://console.cloud.google.com/projectselector2/home/dashboard

# Set parameters
export GKE_PROJECT=valid-octagon-330106
export GKE_CLUSTER=xyz-demo-cluster
export GKE_APP_NAME=xyz-demo-shop
export GKE_SERVICE=xyz-service
export GKE_SERVICE_ACCOUNT=xyz-serviceaccount
export GKE_DEPLOYMENT_NAME=xyz-demo-shop-deployment

# Get a list of regions:
# $ gcloud compute regions list
#
# Get a list of zones:
# $ gcloud compute zones list
export GKE_REGION=europe-west3
export GKE_ZONE=europe-west3-a

# Just a placeholder for the first deployment
export GITHUB_SHA=Test

gcloud config set project $GKE_PROJECT
gcloud config set compute/zone $GKE_ZONE
gcloud config set compute/region $GKE_REGION

# Create a GKE cluster
gcloud container clusters create $GKE_CLUSTER --num-nodes=1

# Configure kubctl
gcloud container clusters get-credentials $GKE_CLUSTER

# enable API
gcloud services enable \
	containerregistry.googleapis.com \
	container.googleapis.com \
  artifactregistry.googleapis.com

# Create repository
gcloud artifacts repositories create $GKE_PROJECT \
   --repository-format=docker \
   --location=$GKE_REGION \
   --description="Docker repository"

# Create a service account
gcloud iam service-accounts create $GKE_SERVICE_ACCOUNT \
    --display-name "GitHub Deployment" \
    --description "Used to deploy from GitHub Actions to GKE"

# Get mail of service account
gcloud iam service-accounts list

GKE_SVC_MAIL="$GKE_SERVICE_ACCOUNT@$GKE_PROJECT.iam.gserviceaccount.com"

# Add 'container.clusterAdmin' role:
gcloud projects add-iam-policy-binding $GKE_PROJECT \
  --member=serviceAccount:$GKE_SVC_MAIL \
  --role=roles/container.clusterAdmin 

# Add 'artifactregistry.admin' role:
gcloud projects add-iam-policy-binding $GKE_PROJECT \
  --member=serviceAccount:$GKE_SVC_MAIL \
  --role=roles/artifactregistry.admin

# Download JSON
gcloud iam service-accounts keys create key.json --iam-account=$GKE_SVC_MAIL

# Build and push the docker image
docker build --tag \
  "$GKE_REGION-docker.pkg.dev/$GKE_PROJECT/$GKE_PROJECT/$GKE_APP_NAME:$GITHUB_SHA" \
  src/Tailwind.Traders.Web/
gcloud auth configure-docker $GKE_REGION-docker.pkg.dev --quiet
docker push "$GKE_REGION-docker.pkg.dev/$GKE_PROJECT/$GKE_PROJECT/$GKE_APP_NAME:$GITHUB_SHA"

# Create deployment
envsubst < src/Tailwind.Traders.Web/Deployment.yml | kubectl apply -f -

# Create service
envsubst < src/Tailwind.Traders.Web/Service.yml | kubectl apply -f -

kubectl get service
echo ""
echo "Note: if the EXTERNAL-IP is still pending you have to wait and run 'kubectl get service' again to find out the external ip to test the application!"
echo ""

echo ""
echo "Please create a secret named 'GKE_SA_KEY' in GitHub with the followign content:"
echo ""
cat key.json | base64
echo ""