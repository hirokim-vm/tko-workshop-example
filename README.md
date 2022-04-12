## tanzu-workshop-example

Please edit this file as you see fit. This is a sample TechDocs application created by https://developer.mckesson.com

This will deploy a sample app into dev `GKE/US` under the `developer-portal-sandbox-dev` namespace.

In order to deploy into prod, you must create a GitHub Environment with relevant secrets.

# Getting Started

This application uses [GitHub Actions](https://docs.github.com/en/actions) and [GitHub Environments](https://docs.github.com/en/actions/reference/environments) to deploy into Kubernetes.

GitHub Environments with populated secrets must be created.

Please follow all `TODO`'s in the manifest files in order to deploy to desired cluster and namespace. Please read the following markdown files before you continue.

- [PIPELINE.md](template-docs/PIPELINE.md)

- [SECRETS.md](template-docs/SECRETS.md)

- [DEPLOY.md](template-docs/DEPLOY.md)

### Reference Documentation

For further reference, please consider the following sections:

- [TechDocs documentation](https://backstage.io/docs/features/techdocs/techdocs-overview)

