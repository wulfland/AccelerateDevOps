# Creating and publishing a docker image to `ghcr.io`

1. Create a new repsitory `container-demo` and add a new file namend Dockerfile (without extension). Add the following content:

    ```dockerfile
    FROM alpine
    CMD ["echo", "Hello World!"]
    ```
    
    If you want to test this locally, clone your repository and change directory to it. Build and run the image. The output is `Hello World!`:
    
    ```bash
    $ docker build -t container-demo .
    $ docker run --rm container-demo
    > Hello World!
    ```
2. Create a workflow file `.github/workflows/release-container.yml` with the following content and commit/push it to your repository:

    ```YAML
    name: Publish Docker image

    on:
      release:
        types: [published]

    env:
      REGISTRY: ghcr.io
      IMAGE_NAME: ${{ github.repository }}

    jobs:
      build-and-push-image:
        runs-on: ubuntu-latest
        permissions:
          contents: read
          packages: write

        steps:
          - name: Checkout repository
            uses: actions/checkout@v2

          - name: Log in to the Container registry
            uses: docker/login-action@v1.10.0
            with:
              registry: ${{ env.REGISTRY }}
              username: ${{ github.actor }}
              password: ${{ secrets.GITHUB_TOKEN }}

          - name: Extract metadata (tags, labels) for Docker
            id: meta
            uses: docker/metadata-action@v3.5.0
            with:
              images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}

          - name: Build and push Docker image
            uses: docker/build-push-action@v2.7.0
            with:
              context: .
              push: true
              tags: ${{ steps.meta.outputs.tags }}
              labels: ${{ steps.meta.outputs.labels }}
    ```
    
3.  The workflow gets triggered if you publish a new release. Navigate to `Source` and click on `Create a new release`:
   
    <img width="750" alt="006_new-release" src="https://user-images.githubusercontent.com/5276337/136688787-a9acdb8d-0df8-4148-988c-2a5256af8510.png">
    
4. Enter `v1.0.0` as a `tag` and hit enter:
 
    <img width="350" alt="007_create-tag" src="https://user-images.githubusercontent.com/5276337/136688843-038f5690-2bb2-4a73-9791-77a3cddd8e95.png">
   
5. Enter a name for the release and publish it:

    <img width="500" alt="008_publish-release" src="https://user-images.githubusercontent.com/5276337/136688869-66241e66-5799-4d4b-8fb0-5b74aeb81ecd.png">
  
6. If the workflow has completed you can see the `container-demo` package under `Code` | `Packages`. Click on it to see details:

    <img width="500" alt="009_package-info" src="https://user-images.githubusercontent.com/5276337/136688981-0a9d75cc-f875-4270-999e-f5aa00978f79.png">

7. To test the image, pull it from the library and run it: 

    ```
    $ docker pull ghcr.io/<github-user>/container-demo:latest
    $ docker run  --rm ghcr.io/<github-user>/container-demo:latest
    > Hello World!
    ```
