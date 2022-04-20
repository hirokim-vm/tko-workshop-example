### Manage multiple clusters with VMWare Tanzu Miission Control

#### Step 1: Login VMware Cloud Service

- Open a broswer with "https://console.cloud.vmware.com/".
- Sign in with McKesson UAT OKTA.

#### Step 2: Launch VMware Tanzu Mission Control

- Click the link of `LAUNCH SERVICE` inside the pane of "__VMware Tanzu Mission Control__"

#### Step 3: Create a cluster group: sandbox

- Click `Cluster Groups` at left side.
- Click the button of `CREATE CLUSTER GROUP`.
- Fill the field of `Name` with "__sandbox__"
- Enter "__Group of test clusters__" in the field of `Description (optional)`.
- Click the button of `CREATE`.

#### Step 4: Attach two clusters: aks-westus-test and gke-uswest1-test

Attach cluster "__aks-westus-test__" as follows:

- Click `Clusters` at left side.
- Click `ATTACH CLUSTER` button.
- Enter "__aks-westus-test__" in the field of `Cluster name`.
- Select '__sandbox__' in the dropdown menu `Cluster group`.
- Enter "__aks sandbox__" in the field `Description (optional)`.
- Click `Next`.
- Click `Next`.
- Copy the command and run it in the context of `aks-westus-test`.

```
# sample command
kubectl create -f "https://mckesson.tmc.cloud.vmware.com/installer?id=367f54b439609ed5cce3029cf673eadd379fa4967282149549a31205629bdd22&source=attach"
```

- Wait for a minute.
- Click `VERIFY CONNECTION`.

Repeat above steps to attach cluster "__gke-uswest1-test__":

- Click `Clusters` at left side.
- Click `ATTACH CLUSTER` button.
- Enter "__gke-uswest1-test__" in the field of `Cluster name`.
- Select '__sandbox__' in the dropdown menu `Cluster group`.
- Enter "__gke sandbox__" in the field `Description (optional)`.
- Click `Next`.
- Click `Next`.
- Copy the command and run it in the context of `gke-uswest1-test`.

```
# sample command
kubectl create -f "https://mckesson.tmc.cloud.vmware.com/installer?id=17c1e18cc31b7e3933f2b55b0df44617380aff375bd093718bbe51906b278489&source=attach"
```

- Wait for a minute.
- Click `VERIFY CONNECTION`.

#### Step 5: Create four workspaces: medium, small, registry, and network

Create workspace "__medium__" as follows:

- Click `Workspaces` at left side.
- Click `CREATE WORKSPACE` button.
- Enter "__medium__" in the field of `Name`.
- Enter "__Workspace for medium resource request__" in the field `Description (optional)`.
- Click `CREATE`.

Create workspace "__small__" as follows:

- Click `Workspaces` at left side.
- Click `CREATE WORKSPACE` button.
- Enter "__small__" in the field of `Name`.
- Enter "__Workspace for small resource request__" in the field `Description (optional)`.
- Click `CREATE`.

Create workspace "__registry__" as follows:

- Click `Workspaces` at left side.
- Click `CREATE WORKSPACE` button.
- Enter "__registry__" in the field of `Name`.
- Enter "__Workspace for image registry policy__" in the field `Description (optional)`.
- Click `CREATE`.

Create workspace "__network__" as follows:

- Click `Workspaces` at left side.
- Click `CREATE WORKSPACE` button.
- Enter "__network__" in the field of `Name`.
- Enter "__Workspace for network policy__" in the field `Description (optional)`.
- Click `CREATE`.

#### Step 6: Create an Access policy

"Access policies allow you to use predefined roles to specify which identities (individuals and groups) have what level of access to a given resource."

Create a Rolebinding of the role "Cluster.view" for clustre group `sandbox`:

- Click `Policies` at left side.
- Click `Assignment`.
- Click `McKesson`.
- Click `sandbox`.
- Click `sandbox` under `Direct access policies`.
- Select `cluster.view: Read access to ...` in the dropdown menu `Role`.
- Enter "__user__" to `Identities`.
- Enter "__edward.ma@mckesson.com__" to `user identity`.
- Click `SAVE`.
- Check aks-westus-test

```execute
k get rolebinding -A|grep sandbox
```

#### Step 7: Create an Image registry policy

"Image registry policies allow you to specify the source registries from which an image can be pulled."

- Create namespace "__tmc-demo__" in `aks-westus-test`.

```execute
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: tmc-demo
  labels:
    registry: platform
EOF
```

- Create namespace "__tmc-demo-labels__" in `aks-westus-test`.

```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: tmc-demo-labels
  labels:
    owner: platform
EOF
```

- Add namespace `tmc-demo` to workspace `registry`
  - Click `Namespaces` at left side.
  - Select namespaces `tmc-demo`.
  - Click `ATTACH 2 NAMESPACES`.
  - Select `registry` from the dropdown menu on the pop `Attach namespaces`.
  - Click `ATTACH`.

Create an image registry policy to prevent applications in namespace `tmc-demo` from pulling images from other hosts than `mck-tech-platform-srvs.jfrog.io`:

- Click `Policies` at left side.
- Click `Assignments`.
- Click `Image registry`.
- Click `WORKSPACES`.
- Click `registry`.
- Click `CREATE IMAGE REGISTRY POLICY`.
- Click `Direct Image registry policies`.
- Select `Custom` from `Image registry template`.
- Click `Rule`.
- Enter "__mck-tech-platform-srvs.jfrog.io__" to `Hostname (optional)` in `Rule`.
- Click `ADD ANOTHER RULE`.
- Enter `registry`, `platform` to `Label selectors`.
- Click `ADD LABEL SELECTOR`.
- Click `CREATE POLICY`.

Try to create a pod with nginx image from Docker hub on aks-westus-test:

```execute
k -n tmc-demo run nginx --image nginx
```

Try to create a pod with nginx image from Docker hub on gke-uswest1-test:

```execute
k -n tmc-demo run nginx --image nginx
```

#### Step 8: Create a Network policy

"Network policies allow you to use preconfigured templates to define how pods communicate with each other and other network endpoints."

Create a `deny-all-to-pods policy`, "__deny-all-to-pods-tmc-demo__", with `Pod selectors`, "__network=tmc-demo__".

- Create namespace "__tmc-demo-np__" in `aks-westus-test`.

```execute
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: tmc-demo-np
  labels:
    network: tmc-demo
EOF
```

- Create namespace "__tmc-demo-np__" in `gke-uswest1-test`.

```copy
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: tmc-demo-np
  labels:
    network: tmc-demo
EOF
```

- Attach `tmc-demo-np` to workspace group `network`.

```execute
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  namespace: tmc-demo-np
  labels:
    network: tmc-demo
spec:
  containers:
  - name: nginx-pod
    image: mck-tech-platform-srvs.jfrog.io/nginx
    resources:
      requests:
        memory: "128Mi"
        cpu: "128m"
      limits:
        memory: "256Mi"
        cpu: "250m"
  imagePullSecrets:
  - name: jfrogcred
EOF
```

#### Step 9: Create a Security policy

"Security policies allow you to manage the security context in which deployed pods operate in your clusters by imposing constraints on your clusters that define what pods can do and which resources they have access to."

#### Step 10: Create a Quota policy

"Quota policies allow you to constrain the resources used in your clusters, as aggregate quantities across specified namespaces, using preconfigured and custom templates."

#### Step 11: Create a Custom policy

"Custom policies allow you to implement additional business rules, using templates that you define, to enforce policies that are not already addressed using the other built-in policy types."
