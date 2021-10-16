#!/bin/bash

appName=xyz-demo-shop
location=westeurope

# In case you want to name the resource group different than the app:
rgname=$appName

# Create a new resource group
az group create --name $rgname --location $location

# Create an app service plan
# We use  paid one (SKUP1V2) to use deployment slots!
az appservice plan create \
    --resource-group $rgname \
    --name $appName-plan \
    --is-linux \
    --sku P1V2

# Create the web app
az webapp create \
    --name $appName \
    --plan $appName-plan \
    --resource-group $rgname \
    --runtime "DOTNET|5.0"

echo "Deployment completed."
echo "Create a secret 'AZUREAPPSERVICE_PUBLISHPROFILE' in your repository with the following content:"

az webapp deployment list-publishing-profiles \
    --resource-group $rgname \
    --name $appName \
    --xml