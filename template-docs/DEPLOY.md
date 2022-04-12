# Deploy

#### Cluster Namespace

Please update _both_ manifest files in the `.kube` folder, change the namespace on `Line 11` + `Line 46` + `Line 62` to reflect the namespace of your cluster(s).

#### Cluster Domain

In order to access your application through McKesson's DNS, please update _both_ manifest files on `Line 68` + `Line 70`.

Change `.cluster.domain.com` with the possibilities below.

It should look like `my-application-dev.dev.cs.east.eu.mckesson.com`

Please note, the manifest-dev.yml files should be aimed at `DEV` instances of a cluster. Likewise, the `manifest-prod.yml` file should be aimed to a `PROD` instance of a cluster. This a list of the current `DEV` and `PROD` Cluster Domain possibilities.

DEV

---

EU / GKE:
`.dev.cs.east.eu.mckesson.com`

US / GKE:
`.dev.cs.west.us.mckesson.com`

US / AKS:
`.dev.aks.west.us.mckesson.com`

PROD

---

EU / GKE:
`.cs.west.eu.mckesson.com`

US / GKE:
`.cs.west.us.mckesson.com`

US / AKS:
`.aks.west.us.mckesson.com`

#### Ports

If your application container should be accessed by a non default port (8080), please update the `manifest-dev/prod.yml` files to reflect that.
