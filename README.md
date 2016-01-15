# openshift-letsencrypt

Template for running a nginx container for a static website.

### Installation

You need oc (openshift cli tool) localy installed:

create a new project

```sh
oc new-project openshift-letsencrypt \
    --description="Letsencrypt - static nginx" \
    --display-name="Letsencrypt static"
```

####Clone the repository

```sh
git clone git@github.com:ure/openshift-letsencrypt.git
cd openshift-letsencrypt
```

Create the BuildConfig

```sh
oc create -f BuildConfig.yaml
oc create -f DeploymentConfig.yaml
```

#### route.yml

Routes to a static hostname

```sh
oc create -f route.yaml
```
