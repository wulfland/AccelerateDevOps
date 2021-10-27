# Hands-on: Deploy to Google Kubernetes Engine (GKE)

In this hands-on you will deploy a simple container application to `Google Kubernetes Engine` (`GKE`) using GitHub Actions.

1. __Create a cloud project__ in [console.cloud.google.com](https://console.cloud.google.com/projectselector2/home/dashboard) and note the project-id (not the name!).

1. __Create a fork__ of [this repository](https://github.com/wulfland/AccelerateDevOps) (if you haven'nt done so) by clicking the `Fork` button at the top right corner. 

2. __Open [setup-gke.sh](setup-gke.sh)__ and replace the value of `GKE_PROJECT` with your project-id:

    ```bash
    export GKE_PROJECT=valid-octagon-330106
    ```
 
    Also replace `xyz` with for example your username in the names of the cluster and the service:  

    ```bash
    export GKE_CLUSTER=xyz-demo-cluster
    export GKE_APP_NAME=xyz-demo-shop
    export GKE_SERVICE=xyz-service
    export GKE_SERVICE_ACCOUNT=xyz-serviceaccount
    export GKE_DEPLOYMENT_NAME=xyz-demo-shop-deployment
    ```

    Adjust region and zone with the values of your choice. You can get a list of available regions with the command `$ gcloud compute regions list` and a list of the zones with `$ gcloud compute zones list`. You can execute tis commands in the cloud shell in step 3:

    ```bash
    export GKE_REGION=europe-west3
    export GKE_ZONE=europe-west3-a
    ```

    Commit and push the changes to your forked repository.

3. __Open [Google Cloud Shell](https://cloud.google.com/shell)__ and authenticate.

4. __Clone__ your forked repository to the cloud shell. Change directory and mark the setup script as executable:

    ```console
    $ git clone https://github.com/<github-handle>/AccelerateDevOps.git
    $ cd AccelerateDevOps/ch9_release/
    $ chmod +x setup-gke.sh
    ```

5. __Execute the script__ [setup-gke.sh](setup-gke.sh):

    ```console
    $ ./setup-gke.sh
    ```

    The script create a cluster, service account, and artifact repository.

6. __Add a [new repository secret](/../../settings/secrets/actions/new)__ with the name `GKE_SA_KEY` and the value from key.json that is also displayed at the console. Add another secret `GKE_PROJECT` with the project-id from step 1.

7. 


kubectl create deployment xyz-demo-shop-deployment --image europe-west3-docker.pkg.dev/valid-octagon-330106/valid-octagon-330106/xyz-demo-shop:test

kubectl scale deployment xyz-demo-shop-deployment --replicas 3
deployment.apps/xyz-demo-shop-deployment scaled

kubectl expose deployment xyz-demo-shop-deployment --name xyz-demo-shop-service --type=LoadBalancer --port 80 --target-port 80

kubectl get service
