# openshift-letsencrypt

Template for running a nginx container for a static website.

###Installation

You need oc (openshift cli tool) localy installed:

create a new project

```sh
oc new-project openshift-letsencrypt \
    --description="Letsencrypt - automatic ssl certificate creation" \
    --display-name="Letsencrypt"
```

####Clone the repository

```sh
git clone git@github.com:ure/openshift-letsencrypt.git
cd openshift-letsencrypt
```

####Create the app

```sh
oc create -f BuildConfig.yaml
oc create -f DeploymentConfig.yaml
oc create -f GlusterFS-Cluster.yaml
oc create -f PersistentVolumeClaim.yaml
oc new-app https://github.com/ure/openshift-letsencrypt.git
oc start-build openshift-letsencrypt
```

####Add some external routes

Routes to a static hostname (edit !!)

```sh
oc create -f Route.yaml
```
