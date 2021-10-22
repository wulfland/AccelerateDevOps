# Hands-on: Deploy to AWS Elastic Container Service (ECS)

In this hands-on lab you will deploy a simple container to Amazon AWS `Elastic Container Services` (ECS) using GitHub Actions.

1. __Create a Amazon ECR container registry__:  
    Open the [Cloud Shell](https://aws.amazon.com/de/cloudshell/) and log in with your AWS account. Run the following commands and adjust `AWS_REGION` with your desired region (you can find all regions in the top right corner in AWS). Adjust `ECR_REPOSITORY`to be unique and replace xyz i.e. with your user name. 

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

2. __Fork the repository__: Fork [this repository](https://github.com/wulfland/AccelerateDevOps) (if you haven'nt done so) by clicking the `Fork` button at the top right corner. 

3. __Create access key__: In AWS go to `My Security Credentials` | `Access keys`| `Create New Access Key`: 

    ![001_create_access_key.png](001_create_access_key.png)

    Note the `Access Key ID` and `Secret Access Key`:

    ![002_IAM Management Console.png](002_IAM Management Console.png)

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

    ![003_First-Run.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\003_First-Run.png)

    It is expected that the second job `Deploy` will fail as we hav not jet configured ECS. But `Build` will work and publish our image to the registry.

    Expand `Build, tag, and push image to Amazon ECR` and copy the image name:

    ![004_Imagename.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\004_Imagename.png) 

7. __Create cluster and ECS__: Open the [Getting Started with Amazon Elastic Container Service (Amazon ECS) using Fargate](https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/firstRun) wizard (be aware that this url contains the region!).

    Click `Configure` on the `custom` tile.

    ![005-Amazon ECS.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\005-Amazon ECS.png)

    Enter the 'container name' you set in yaml and the image name you copied in the previouse step. Set the port to 80: 

    ![006_Image.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\006_Image.png)

    Click `Next`.

    Select the `Application Load Balancer` and click `Next`:

    ![007_Amazon ECS.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\007_Amazon ECS.png)

    Set the `Cluster name` to the value from the yaml in step 5.

    ![008_Cluster.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\008_Cluster.png)

    Click `Next' and create the cluster.

    ![009_Amazon ECS.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\009_Amazon ECS.png)

    Wait until all resource have been created and click `View service`:

 8. __Copy and save taskrun definition__: Click on the task definition link:

    ![010_cluster.png]("C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\010_cluster.png")

    Copy all the content from the `JSON` tab to your clipboard.

    ![011_taskdef.png]("C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\011_taskdef.png")

    Open the file [ch9_release/aws-task-definition.json](/../../blob/main/ch9_release/aws-task-definition.json), edit it, and past the content. Commit the file.

9. __Check that your container is running__: To see that you container is running we have to find the DNS name of the load balancer. Go back to your cluster and open the target group:

    "C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\012_lb1.png"

    Click the load balancer in the group:

    "C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\013_lb2.png"

    In the loadbalancer you see the DNS name under `Description`. Copy it:

    "C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\014_lb3.png"

    Paste it into a new browser window or tab. You should see the Tailwind Traiders website from our container:

    "C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\015_running container.png"

10. __Run the workflow again__: Manually trigger [the workflow again](/../../actions/workflows/Deploy-AWS.yml).

    ![003_First-Run.png](C:\Users\kaufm\Packt\B17827 - Accelerate DevOps with GitHub - General\B17827\img\B17827_09\aws\003_First-Run.png)

    This time your workflow runs without error and deploys your latest version of the container.
