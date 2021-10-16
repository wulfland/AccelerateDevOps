#!/bin/bash

# Delete the entire resourcegroup!

rgname=xyz-demo-shop

az group delete --resource-group $rgname --yes