# Hands-on: Deploy to Google Kubernetes Engine (GKE)

In this hands-on you will deploy a simple container application to `Google Kubernetes Engine` (`GKE`) using GitHub Actions.

1. __Create a cloud project__ in [console.cloud.google.com](https://console.cloud.google.com/projectselector2/home/dashboard) and note the project-id (not the name!).

2. __Create a fork__ of [this repository](https://github.com/wulfland/AccelerateDevOps) (if you haven't done so) by clicking the `Fork` button at the top right corner. 

3. __Open [setup-gke.sh](setup-gke.sh)__ and replace the value of `GKE_PROJECT` with your project-id:

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

4. __Open [Google Cloud Shell](https://cloud.google.com/shell)__ and authenticate.

5. __Clone__ your forked repository to the cloud shell. Change directory and mark the setup script as executable:

    ```console
    $ git clone https://github.com/<github-handle>/AccelerateDevOps.git
    $ cd AccelerateDevOps/ch9_release/
    $ chmod +x setup-gke.sh
    ```

6. __Execute the script__ [setup-gke.sh](setup-gke.sh):

    ```console
    $ ./setup-gke.sh
    ```

    The script creates a cluster, artifact repository, and service account. 
    It than builds the docker container, uploads it to the artifact registry, and deploys it to the cluster.

    The script executes `kubectl get service` - but probably your IP takes some time to get provisioned. Wait some time and execute the command again until you see an IP address:

    <img width="589" alt="01_get-service" src="https://user-images.githubusercontent.com/5276337/139122676-d6df1cbf-97be-4b5b-9de8-e73e3ed0a7b3.png">

    Open the IP in browser and verify that the container is running successfully:

    <img width="500" alt="02_app-in-cluster" src="https://user-images.githubusercontent.com/5276337/139122712-7d7d1b33-88e2-442f-abeb-5d2de3e2468c.png">

    The script also reads the `key.json`. You could run the following command again if you missed it:

    ```console
    $ cat key.json | base64
    ``` 

    Copy the base64 encoded content of the file to your clipboard.

    <img width="616" alt="03_key-json" src="https://user-images.githubusercontent.com/5276337/139122765-fa11869d-57a3-4a53-88f1-fcd02cf30aff.png">

6. __Add a [new repository secret](/../../settings/secrets/actions/new)__ with the name `GKE_SA_KEY` and the value from key.json (past it from your clipboard or go back to the console to copy it). Add another secret `GKE_PROJECT` with the project-id from step 1.

7. __Edit [Deploy-GKE.yml](/../../blob/main/.github/workflows/Deploy-GKE.yml)__ in `.github/workflows/` and replace the values under `env:` with the same values in step 3:

```yaml
env:
  GKE_PROJECT: ${{ secrets.GKE_PROJECT }}
  GKE_CLUSTER: xyz-demo-cluster
  GKE_APP_NAME: xyz-demo-shop
  GKE_SERVICE: xyz-service
  GKE_SERVICE_ACCOUNT: xyz-serviceaccount
  GKE_DEPLOYMENT_NAME: xyz-demo-shop-deployment
  GKE_REGION: europe-west3
  GKE_ZONE: europe-west3-a
```

8. __Have a look__ at [Service.yml](/../../blob/main/ch9_release/src/Tailwind.Traders.Web/Service.yml) and [Deployment.yml](/../../blob/main/ch9_release/src/Tailwind.Traders.Web/Deployment.yml). You don't have to modify the files - just take a look at them as they will perform the deployment. The environment variables will be replaced during the deployment.

9. __Run the workflow [Deploy-GKE.yml](/../../actions/workflows/Deploy-GKE.yml)__ under `Actions` | `Deploy-GKE` | `Run workflow`:

    <img width="1102" alt="04_run-workflow" src="https://user-images.githubusercontent.com/5276337/139122808-6214aa62-79d3-4cd3-a340-3dba0bd43325.png">

    The workflow will build the docker container and deploy it to your cluster.

    <img width="1094" alt="05_success" src="https://user-images.githubusercontent.com/5276337/139122843-1a725f4c-4729-437a-9b5d-74b1bd6f1b41.png">

10. __Clean up__ your resources by executing the [destroy-gke.sh](destroy-gke.sh) script:

    ```console
    $ chmod +x destroy-gke.sh
    $ ./destroy-gke.sh
    ```
