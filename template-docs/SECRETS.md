# Secrets

The workflow files rely on GitHub Environments where GitHub Secrets of the same name can be stored, but with different values for each environment.

These secrets can then be referenced within the YAML definition of the workflow.

Find out more about [GitHub Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets) and [GitHub Environments](https://docs.github.com/en/actions/reference/environments)

#### List of Secrets

`JFROG_USERNAME` - Username of account that can deploy into your Artifactory docker registry, we recommend that you use a service account

`JFROG_API_KEY` - API key of account that can deploy into your Artifactory docker registry, we recommend that you use a service account

`KUBERNETES_SA_TOKEN` - The token value of the a Kubernetes service account in your namespace _Note: It is recommended that you create this secret per Environment in your GitHub repository, with a different value for each of your Kubernetes namespaces you wish to deploy into._

#### How to get Secrets

`JFROG_USERNAME` - Log into [Artifactory](https://mck.jfrog.io) with your service account. The username will be in the top right hand corner _For example: user@mckesson.com_. Store that value as the secret. Change `DEV_PORTAL_JFROG_USERNAME` to `JFROG_USERNAME` or whatever the name of your new secret is in the relevant workflow files.

`JFROG_API_KEY` - Under User Profile settings in Artifactory click the Copy to Clipboard, or Generate API Key if you have not done so. Please keep this value safe. Store that value as the secret. Change `DEV_PORTAL_JFROG_API_KEY` to `JFROG_USERNAME` or whatever the name of your new secret is in the relevant workflow files.

`KUBERNETES_SA_TOKEN` - Authenticate with a user into the relevant Kubernetes cluster you wish to deploy into. Run the following steps in sequence: _(Changing any values with angle brackets <>)_.

1. `kubectl get serviceaccount -n namespace`

2. Run the following command:

   `kubectl get secret/$(kubectl get sa/namespace-sa -n namespace -o jsonpath="{.secrets[0].name}") -n namespace -o go-template --template="{{.data.token | base64decode}}" && echo`

3. Copy the complete string and store this as the secret

After, change `DEV_PORTAL_KUBE_SA_US` to `KUBERNETES_SA_TOKEN` or whatever the name of your new secret is in the relevant workflow files.

### Create docker-registry-credentials secret from CLI

In order for your deployment to pull the docker image(s) from the specified jFrog Artifactory Docker Registry, in the relevant Kubernetes cluster(s) a Docker Registry secret must be created.

`kubectl create secret docker-registry docker-registry-credentials --docker-server=$DOCKER_REGISTRY --docker-username=$DOCKER_USER --docker-password=$DOCKER_API_KEY`
