Tanzu Workshop Example
======================

Sample workshop content using Markdown formatting for pages based on "LAB - Markdown Sample"

If you already have the Tanzu Learning Center installed and configured, to
deploy and view this sample workshop, run:

```bash
kubectl apply -f resources/workshop.yaml
kubectl apply -f resources/training-portal.yaml
kubectl delete pod -l deployment=learningcenter-operator -n learningcenter
```

This will deploy a training portal hosting just this workshop. To get the
URL for accessing the training portal run:

```bash
kubectl get trainingportal/tanzu-workshop-example
```

The training portal is configured to allow anonymous access. For your own
workshop content you should consider removing anonymous access.

## References

[LAB - Markdown Sample](https://github.com/eduk8s/lab-markdown-sample)
