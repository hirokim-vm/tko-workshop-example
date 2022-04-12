### GitHub Actions Pipeline

#### How It Works

GitHub Actions pipelines are stored within this repository in YAML definition under the `.github/workflows` folder. One can specify tasks to run on certain events, for example, a git commit or a pull request.
The pipeline in this repository is made up of two 'workflow' files': `ci-and-release.yml` and `deploy.yml`.

Per your specific deployment environment needs, it is recommended that a GitHub Environment is created to mimic that environment so that the correct secrets can be used be picked up.

#### Environments

Please create a GitHub Environment named `prod` and `dev`. Feel free to create as many environments as you wish.

You must create duplicates of the following secrets in all environments. The secrets must have the same name, but with different values.

_eg. a deployment key `KUBERNETES_SA_TOKEN`: one copy with a value to deploy into the `dev` env and one copy with a value to deploy into the `prod` env._

You must also have a manifest file per environment in the `.kube` folder, _e.g. `manifest-dev.yml` and `manifest-prod.yml`._

For each of your GitHub environments: `dev`, `qa`, `staging`, `test`, `prod` etc. You must create a manifest file in the `.kube` folder which references the name of the environment in the title _eg `manifest-qa.yml`_

Find out more about [GitHub Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets) and [GitHub Environments](https://docs.github.com/en/actions/reference/environments)

#### `ci-and-release.yml`

This workflow will run any time a commit to a remote branch is received.
The workflow will checkout the branch at the current stage of the commit and will run the following steps:

1. Compiles the repository code
   For example, running a gradle build command to ensure the code compiles and the tests run successfully.

2. Builds a Docker image
   Once the code has been compiled into an executable, the pipeline will check to see if a Docker image can be created

3. Creates a pre-release
   The pipeline calculates the next semantic version, for example, 0.0.1 -> 0.0.2, and creates a pre-release with that tag. If this version gets deployed at a later stage, it can be marked as a release which then can be found easily in the UI of the GitHub repository.

4. (conditional) Pushes the Docker image
   If the workflow detects a commit to the 'main' branch, for example, if a Pull Request is merged into the main branch from a feature branch, all previously explained steps will run and if successful, the docker image will be pushed the docker repository with the semantic version as the docker tag.

#### `deploy.yml`

This workflow needs to be manually triggered by inputting the version of the application you wish to deploy, and the environment to which you wish to deploy into.

#### Example Deployment

For example, let's say a docker image with version 0.0.2 is created via a previous `ci-and-release.yml` workflow and needs to be deployed into the development environment.

1. Navigate to the workflow page
   You can do so by visiting the workflow on the Actions tab or by following this link and clicking on the `Run Workflow` button
   https://github.com/mckesson/tanzu-workshop-example/actions/workflows/deploy.yml

2. Input 'dev' into 'Environment to deploy to' field

3. Input '0.0.2' into 'Docker tag to deploy' field

4. Click 'Run Workflow'

The workflow will look for a deployment manifest in the `.kube` directory which matches the environment, enter the docker tag into a placeholder and deploy into the the correct environment.
