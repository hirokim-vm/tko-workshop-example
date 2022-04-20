Run following command seting up kubecontext to work with aks-westus-test if needed:

```Copy
az login
az account set --subscription ebfbcf35-035c-48a7-a8e2-bc70bd1ef972
az aks get-credentials --resource-group rg-aks-westus-test --name aks-westus-test --admin --overwrite-existing
```

Run following command seting up kubecontext to work with gke-uswest1-test if needed:

```Copy
gcloud auth login

gcloud config set project gke-uswest1-test-1524
gcloud config set compute/region us-west1
 
gcloud container clusters get-credentials gke-uswest1-test --region us-west1 --project gke-uswest1-test-1524
```
