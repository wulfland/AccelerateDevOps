# Hands-on: Deploy to Azure App Service

In this hands-on lab you will deploy a simple website to Azure App Services using GitHub Actions.

1. __Create a fork__ of [this repository](https://github.com/wulfland/AccelerateDevOps) (if you haven'nt done so) by clicking the `Fork` button at the top right corner. 

2. __Open [setup-azure.sh](setup-azure.sh)__ and modify the `appName`. The name will be part of the URL and must be unique. Replace `xyz` for example with your username.  

   ```bash
   appName=xyz-demo-shop
   location=westeurope
   ```

   Also select the datacenter to host the app service by setting the location (westeuope, centralus, eastasia, australia, etc.). If unsure what the best region is, proceed to step 4 and execute the following command to get a list of all available locations:

   ```console
   $ az account list-locations --query '[].name'
   ```
3. __Commit__ your changes to the forked repository.

4. __Open cloud shell__  
   The easiest way to get started is by opening the Azure Cloud Shell at [https://shell.azure.com](https://shell.azure.com). You can alternately use the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) if you've installed it locally. (For more information on Cloud Shell, see the [Cloud Shell Overview](https://docs.microsoft.com/azure/cloud-shell/overview.).

5. __Clone__ your fork inside the cloud shell and make [setup-azure.sh](setup-azure.sh) executable: 

   ```console
   $ git clone https://github.com/wulfland/AccelerateDevOps.git
   $ cd AccelerateDevOps/ch9_release/
   $ chmod +x setup-azure.sh

6. __Run [setup-azure.sh](setup-azure.sh)__ and copy the publish profile at the end of the script.

   ```console
   $ ./setup-azure.sh
   ```

   Verify that your app is running by opening the URL [https://xyz-demo-shop.azurewebsites.net](https://xyz-demo-shop.azurewebsites.net) (replace `xyz-demo-shop` with the `appName` you set in your script.)

   <img width="1103" alt="09_001_Validate-setup" src="https://user-images.githubusercontent.com/5276337/137623549-ecc96732-7861-4f3f-8539-8339571f2a3f.png">
   
7. __Create a [new Environment](/../../settings/environments/new)__ under `Settings` | `Environments` | `New environment`. Enter the name `Prod` and click `Configure environment`.

8. Add yourself as a __required reviewer__ and click `Save protection rule`:

    <img width="527" alt="09_02_Create-environment" src="https://user-images.githubusercontent.com/5276337/137623572-996103b6-1e84-41f4-9082-b2fc050e9abd.png">

9. Under `Environment secrets`, __add a new secret__ called `AZUREAPPSERVICE_PUBLISHPROFILE`. Paste the value from step 6 or run the following command to get the publishing profile again:  

   ```console
   $ az webapp deployment list-publishing-profiles \
    --resource-group $rgname \
    --name $appName \
    --xml
   ```

10. __Open [.github/workflows/Deploy-Azure.yml](/../../blob/main/.github/workflows/Deploy-Azure.yml)__ and ajust the app name at the top of the file:

    ```yaml
    env:
     appName: xyz-demo-shop
    ```

    Commit the file to your fork. 

11. __Run the workflow__: Go to `Actions` and select `Deploy-Azure`. Open the `Run workflow` menu and click `Run workflow`:

    <img width="1198" alt="09_003_Run-workflow" src="https://user-images.githubusercontent.com/5276337/137623585-c7abc6c6-36c4-4231-9bd1-a8a71a713187.png">

12. __Approve__: The workflow runs some time to build the app. You'll get notified if the build job completes and the approval is required. Click `Review deployments`:

    <img width="1217" alt="09_004_Approve-workflow" src="https://user-images.githubusercontent.com/5276337/137623602-c8d6d5f2-3db8-428a-a368-c2a9bfa4c42e.png">

    Select the `Prod` environment and select `Approve and deploy`:

    <img width="589" alt="09_005_Approve" src="https://user-images.githubusercontent.com/5276337/137623622-2d7c6956-f960-407a-91c5-98eb679b2e12.png">

13. __Validate__: Wait until the deployment is complete.

    <img width="588" alt="09_006_Progress" src="https://user-images.githubusercontent.com/5276337/137623628-bd9dd029-cc59-4729-ad25-3b9efa4d647d.png">

    Refresh your browser with URL [https://xyz-demo-shop.azurewebsites.net](https://xyz-demo-shop.azurewebsites.net) (replace `xyz-demo-shop` with the `appName` you set in your script.) or open a new browser to validate your deployment.

    <img width="962" alt="09_007_Validate" src="https://user-images.githubusercontent.com/5276337/137623638-60243284-fa97-4764-8ebb-a0b8032ba304.png">

14. __Clean up__: If you are done you can clean up all Azure resource to save money. Delete the resource group by executing the following script from the cloud shell:

    ```console
    $ ./destroy-azure.sh
    ```
