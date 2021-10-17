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

   ![09_001_Validate-setup.png](09_001_Validate-setup.png)

7. __Create a [new Environment](/../../settings/environments/new)__ under `Settings` | `Environments` | `New environment`. Enter the name `Prod` and click `Configure environment`.

8. Add yourself as a __required reviewer__ and click `Save protection rule`:

    ![09_02_Create-environment.png](09_02_Create-environment.png)

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

    ![09_003_Run-workflow.png](09_003_Run-workflow.png)

12. __Approve__: The workflow runs some time to build the app. You'll get notified if the build job completes and the approval is required. Click `Review deployments`:

    ![09_004_Approve-workflow.png](09_004_Approve-workflow.png)

    Select the `Prod` environment and select `Approve and deploy`:

    ![09_005_Approve.png](09_005_Approve.png)

13. __Validate__: Wait until the deployment is complete.

    ![09_006_Progress.png](09_006_Progress.png)

    Refresh your browser with URL [https://xyz-demo-shop.azurewebsites.net](https://xyz-demo-shop.azurewebsites.net) (replace `xyz-demo-shop` with the `appName` you set in your script.) or open a new browser to validate your deployment.

    ![09_007_Validate.png](09_007_Validate.png)

14. __Clean up__: If you are done you can clean up all Azure resource to save money. Delete the resource group by executing the following script from the cloud shell:

    ```console
    $ ./destroy-azure.sh
    ```