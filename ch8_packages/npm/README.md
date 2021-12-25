# Creating and publishing an npm package

1. Create a new repository and select `Node` as your `.gitignore` template:

   <img width="500" alt="001_create-repo" src="https://user-images.githubusercontent.com/5276337/136522864-04c1a503-d647-41f9-bd7e-1670170cdf2b.png">

2. Clone the repository to your local machine or open it in code spaces.

   <img width="400" alt="002_clone or open" src="https://user-images.githubusercontent.com/5276337/136523686-adeb6542-79c5-41d7-8012-6823e52dfec3.png">

    ```console
    $ git clone <URL>
    ```

3. Create a file `index.js` and add some simple JavaScript code, for example:

    ```js
    alert("Hello, World!");
    ```

4. If you have `npm` installed on your machine, run `npm init` and initialize your package using the wizard. Leave the defaults for the other values. 

    ```console
    $ npm init
    ...
    package name: @YOUR-USER/YOUR-REPO
    ...
    test command: exit 0
    ...
    ```

    If you don't have npm installed, just clone this repository and copy the files `package.json` and `package-lock.json` to you local repo. Adjust the URLs and package name to include your username and repo.

5. Commit and push your files:

    ```console
    $ git add index.js package.json package-lock.json
    $ git commit -m "Initialize package"
    $ git push
    ```

6. Create a file `.github/workflows/release-package.yml` and copde the following content to it:

    ```YAML
    name: Node.js Package

    on:
      release:
        types: [created]

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - uses: actions/setup-node@v2
            with:
              node-version: 12
          - run: npm ci
          - run: npm test

      publish-gpr:
        needs: build
        runs-on: ubuntu-latest
        permissions:
          packages: write
          contents: read
        steps:
          - uses: actions/checkout@v2
          - uses: actions/setup-node@v2
            with:
              node-version: 12
              registry-url: https://npm.pkg.github.com/
          - run: npm ci
          - run: npm publish
            env:
              NODE_AUTH_TOKEN: ${{secrets.GITHUB_TOKEN}}
    ```

7. Create a file `.npmrc` in the root of your repository with the following content:

    ```yaml
    @YOUR-USER:registry=https://npm.pkg.github.com
    ```

8. Commit and push the new files:

    ```console
    $ git add .github/workflows/release-package.yml .npmrc
    $ git commit -m "Add workflow to pusblish package"
    $ git push
    ```

9. Create a release. Click on `Releases` under `Code` and click `Draft new Release`. Create a new tag and enter a title. If you create the release, the workflow will automatically run.

    <img width="500" alt="003_create-release" src="https://user-images.githubusercontent.com/5276337/136526942-2b6ebb28-bbe8-46df-84b3-ba02f76cbeb1.png">

10. If the workflow has completed, you can find you package under `Code`.

    <img width="900" alt="004_see-package" src="https://user-images.githubusercontent.com/5276337/136528558-b9283c83-4e9a-4320-b7b0-2bc7601174a6.png">

11. Click on the package to see the details:

    <img width="900" alt="005_package-details" src="https://user-images.githubusercontent.com/5276337/136528589-a25eed4f-6381-4b6d-b4c7-8e28ebc05a08.png">

    > **Note:**  
    > If you want to create new releases, you have to update the version in `package.json`. Otherwise the build will fail.

12. Automatically set package number  
    You can automate this step by adding the `NPM-Version` action and set it to the tag of the release:

    ```YAML
    - name: 'Change NPM version'
      uses: reedyuk/npm-version@1.1.1
      with:
        version: ${{github.event.release.tag_name}}
    ```

    Add this step to you yaml before the `- run: npm ci` step and create a new release. The package version is now set automatically to the tag.

13. Calculate the version with GitVersion
    If you have a more complex workflow you can use `GitVersion` to calculate your version number. You have to make your checkout shallow for that to work:
    
    ```yaml
      - uses: actions/checkout@v2
        with: 
          fetch-depth: 0
    ```
    Now yu can install and execute `GitVersion` and access the version using `$GITVERSION_SEMVER`:

    ```yaml
      - name: Install GitVersion
        uses: gittools/actions/gitversion/setup@v0.9.7
        with:
          versionSpec: '5.x'
          
      - name: Determine Version
        id:   gitversion
        uses: gittools/actions/gitversion/execute@v0.9.7
        
      - name: 'Change NPM version'
        uses: reedyuk/npm-version@1.1.1
        with:
          version: $GITVERSION_SEMVER
    ```

    Now you could modify your workflow to also trigger on tags or branches to create your package:
    
    ```yaml
    on:
      push: 
        tags:
          - 'v*'
        branches:
          - 'release/*'
    ```
