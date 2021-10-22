# Hands-on: Deploy to AWS Elastic Container Service (ECS)

In this hands-on lab you will deploy a simple container to Amazon AWS `Elastic Container Services` (ECS) using GitHub Actions.

1. __Create a Amazon ECR container registry__:  
    Open the [Cloud Shell](https://aws.amazon.com/de/cloudshell/) and log in with your AWS account. Run the following commands and adjust `AWS_REGION` with your desired region (you can find all regions in the top right corner in AWS). Adjust `ECR_REPOSITORY`to be unique and replace `xyz` with your user name. 

    ```console
    $ AWS_REGION=us-east-2
    ```
    ```console
    $ ECR_REPOSITORY=xyz-demo-shop
    ```
    ```console
    $ aws ecr create-repository \
        --repository-name $ECR_REPOSITORY \
        --region $AWS_REGION
    ```

2. __Fork the repository__: Fork [this repository](https://github.com/wulfland/AccelerateDevOps) (if you haven't done so) by clicking the `Fork` button at the top right corner. 

3. __Create access key__: In AWS go to `My Security Credentials` | `Access keys`| `Create New Access Key`: 

    <img width="1112" alt="001_create_access_key" src="https://user-images.githubusercontent.com/5276337/138446505-d9ff0139-9e3b-42c6-b637-476cb51a3e72.png">

    Note the `Access Key ID` and `Secret Access Key`:

    <img width="520" alt="002_IAM Management Console" src="https://user-images.githubusercontent.com/5276337/138446553-b55c2259-7044-4f3a-bef3-820086cd2ea0.png">

4. __Create repository secrets__: In your forked repository go to [Settings | Secrets](/../../settings/secrets/actions) and create to new secrets `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` using the values of the previous step.

5. __Modify workflow file__: Edit [.github/workflows/Deploy-AWS.yml](/../../blob/main/.github/workflows/Deploy-AWS.yml) and adjust the values under `env:`. Use `AWS_REGION` and `ECR_REPOSITORY` from step 1. If you are a new user on AWS, just replace `xyz` with your username. If you already have a cluster running, you can use the name here. The service will be created later.   

    ```yaml
    env:
      AWS_REGION: us-east-2
      ECR_REPOSITORY: xyz-demo-shop
      ECS_SERVICE: xyz-demo-shop-service
      ECS_CLUSTER: default
      ECS_TASK_DEFINITION: ch9_release/aws-task-definition.json
      CONTAINER_NAME: xyz-demo-shop
    ```

    Commit the changes.

6. __Run the workflow__: Manually trigger [the workflow](/../../actions/workflows/Deploy-AWS.yml).

    <img width="1202" alt="003_First-Run" src="https://user-images.githubusercontent.com/5276337/138446585-924877e9-39cd-4f86-bd0e-a349435ec692.png">

    It is expected that the second job `Deploy` will fail as you have not jet configured ECS. But `Build` will work and publish our image to the registry.

    Expand `Build, tag, and push image to Amazon ECR` and copy the image name:

    <img width="889" alt="004_Imagename" src="https://user-images.githubusercontent.com/5276337/138446607-b8d8e0e5-625f-4891-ad6c-080e528c758e.png">

7. __Create cluster and ECS__: Open the [Getting Started with Amazon Elastic Container Service (Amazon ECS) using Fargate](https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/firstRun) wizard (be aware that this URL contains the region!).

    Click `Configure` on the `custom` tile.

    <img width="848" alt="005-Amazon ECS" src="https://user-images.githubusercontent.com/5276337/138446629-d9108df5-e9f2-47b7-8c49-f201d0230677.png">

    Enter the 'container name' you set in yaml and the image name you copied in the previous step. Set the port to 80: 

    <img width="967" alt="006_Image" src="https://user-images.githubusercontent.com/5276337/138446658-4b4b00ab-4b86-4f84-b65b-bd44bd32c18f.png">

    Click `Next`.

    Select the `Application Load Balancer` and click `Next`:

    <img width="665" alt="007_Amazon ECS" src="https://user-images.githubusercontent.com/5276337/138446683-5bf57a23-8696-4aef-8e3c-e07dc6206166.png">

    Set the `Cluster name` to the value from the yaml in step 5.

    <img width="681" alt="008_Cluster" src="https://user-images.githubusercontent.com/5276337/138446716-6e6e8da5-179c-420d-8357-69c7952f0a07.png">

    Click `Next' and create the cluster.

    <img width="937" alt="009_Amazon ECS" src="https://user-images.githubusercontent.com/5276337/138446743-682115bd-295d-4559-ba5c-16b442629185.png">

    Wait until all resource have been created and click `View service`:

 8. __Copy and save the task run definition__: Click on the task definition link:

    <img width="564" alt="010_cluster" src="https://user-images.githubusercontent.com/5276337/138446772-9d84e4a7-06d5-4118-9afb-75e34e7c68f6.png">

    Copy all the content from the `JSON` tab to your clipboard.

    <img width="425" alt="011_taskdef" src="https://user-images.githubusercontent.com/5276337/138446790-bcf2e82e-7781-4f54-98c2-30905fbc5ece.png">

    Open the file [ch9_release/aws-task-definition.json](/../../blob/main/ch9_release/aws-task-definition.json), edit it, and past the content. Commit the file.

9. __Check that your container is running__: To see that your container is running we have to find the DNS name of the load balancer. Go back to your cluster and open the target group:

    <img width="552" alt="012_lb1" src="https://user-images.githubusercontent.com/5276337/138446816-b5f1b684-e0f4-4d5b-98b8-4081db1c6d68.png">

    Click the load balancer in the group:

    <img width="793" alt="013_lb2" src="https://user-images.githubusercontent.com/5276337/138446832-ba261ec4-bbe2-4ed6-828f-ab7fb76ff140.png">

    In the load balancer you see the DNS name under `Description`. Copy it:

    <img width="821" alt="014_lb3" src="https://user-images.githubusercontent.com/5276337/138446856-9022ebb5-d98d-4796-aea8-777abb4509ae.png">

    Paste it into a new browser window or tab. You should see the Tailwind Traders website from our container:

    <img width="775" alt="015_running container" src="https://user-images.githubusercontent.com/5276337/138446884-4f2a9f11-8ba9-4733-a860-8dc2566188a1.png">

10. __Run the workflow again__: Manually trigger [the workflow again](/../../actions/workflows/Deploy-AWS.yml).

    <img width="1202" alt="003_First-Run" src="https://user-images.githubusercontent.com/5276337/138446585-924877e9-39cd-4f86-bd0e-a349435ec692.png">

    This time your workflow runs without error and deploys your latest version of the container.
