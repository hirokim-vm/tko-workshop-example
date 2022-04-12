Install Learning Center according to instructions in "https://docs.vmware.com/en/Tanzu-Application-Platform/1.0/tap/GUID-learning-center-install-learning-center.html"

Prerequisites

- Complete all prerequisites to install Tanzu Application Platform (TAP).

Install

#### List version information for the package by running

```
tanzu package available list learningcenter.tanzu.vmware.com --namespace tap-install
tanzu package available list workshops.learningcenter.tanzu.vmware.com --namespace tap-install
```

#### See all the configurable parameters on this package by running

```execute
tanzu package available get learningcenter.tanzu.vmware.com/0.1.1 --values-schema --namespace tap-install
tanzu package available get workshops.learningcenter.tanzu.vmware.com/0.1.1 --values-schema --namespace tap-install
```

#### Add the parameter ingressDomain to tap-values.yaml

```copy
learningcenter:
  ingressDomain: "test.tapaks.us.mckesson.com"
```

#### Install lerning center by updating TAP

```execute
tanzu package installed update tap -p tap.tanzu.vmware.com -v "1.0.3" --values-file tap-values.yml -n tap-install
```

#### Install the Self-Guided Tour Training Portal and Workshop

```execute
tanzu package install learning-center-workshop --package-name workshops.learningcenter.tanzu.vmware.com --version 0.1.1 -n tap-install
```

#### Force TAP to Reconcile

```execute
function tap-nudge() {
        TAPNS=tap-install
        kubectl -n $TAPNS patch packageinstalls.packaging.carvel.dev $1 --type='json' -p '[{"op": "add",
"path": "/spec/paused", "value":true}]}}' -v0
        kubectl -n $TAPNS patch packageinstalls.packaging.carvel.dev $1 --type='json' -p '[{"op": "add",
"path": "/spec/paused", "value":false}]}}' -v0
}
tap-nudge tap
```

#### References

[Install Learning Center](https://docs.vmware.com/en/Tanzu-Application-Platform/1.0/tap/GUID-learning-center-install-learning-center.html)
