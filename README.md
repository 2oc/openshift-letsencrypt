# openshift-letsencrypt

Template for running a nginx container for a static website.

### Installation

You need oc (openshift cli tool) localy installed:

create a new project

```sh
oc new-project openshift-letsencrypt \
    --description="Letsencrypt - via nginx" \
    --display-name="Letsencrypt static"
```

Create the BuildConfig

```sh
oc create -f BuildConfig.yaml
```

Deploy from public git repository

```sh
oc new-app https://github.com/ure/openshift-letsencrypt.git
```

#### route.yml

Routes to a static hostname

```sh
oc create -f route.yaml
```
#### WebHooks

You can find the (github and generic) webhook in the openshift control pannel ! (Browse - Builds)
You can copy the url to clipboard and paste it in Github webhook url (handy for rolling updates)
