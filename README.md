# Guide

Running the takeon UI & associated services locally using minikube

## Pre-requisites

Getting the services up and running requires pre-installing some software

We make use of envsubst in our scripts, so if you don't have it installed it comes with gettext:

```bash
brew install gettext
brew link --force gettext
```

We also require local kubernetes software. Initially we are using - ```brew cask install minikube```

Please note before installation of minikube, VirtualBox should already be installed. VirtualBox can be installed with - ```brew cask reinstall virtualbox```

## Setting up git repositories

Each repository will be to be cloned/downloaded onto your local machine. The default location identified in ./scripts/kube_env is ~/repo, with each repo located within this (including this one). If you placed your code in different locations then you will need to update this file locally to match your download locations.

A fully populated list would look something like this:

* ~/repo/takeon-persistence-layer
* ~/repo/takeon-ui
* ~/repo/takeon-local-kube
* ~/repo/takeon-business-layer

## Environmental details

These are also located in ./scripts/minikube_env

Using these we can define:

* Image names
* Service name
* Database name
* Repository locations
* Namespace

## Scripts

Each runnable script is found within this repository and is located in ./scripts

Minikube must be running before any of these scripts are run

Logs for each of these scripts are recorded to ./logs

### init.sh

Initialisation steps that don't belong to any particular layer/image. This recreates the namespace and creates any service account details. Uses the corresponding init.yml

### postgres.sh

Uses a predefined dockerfile in the local directory ./postgres to build a standalone postgres image. 
A random username and password will be generated as part of this process (generate_secrets.sh). These database details are placed in (/tmp/minikube_env).

Uses the corresponding postgres.yml and secrets.yml to deploy the image locally.

The database is created and populated using (../mac/testdata/test-data.sql).

Removes the existing database layer. Additionally as the credentials are randomly genereated each time this script will remove any existing persistence and graphQL layers too.

### graphql.sh

Downloads graphQL from Docker and deploys it locally using the corresponsing graphql.yml file. The

### persistence.sh

Builds the Java image using it's own dockerfile and deploys using persistence.yml.

### resetDB.sh

Wraps the DB, QL and persistence layer into a single re-runnable script. this will destroy and recreate all 3 keeping them in step as appropriate.

### business.sh

### ui.sh

### create.sh

Wrapper script around the entire (re)creation process. A single command which will build and deploy all layers into your local minikube.

## Issues / Awareness

If the scripts are not executable after downloading then you will need to use chmod as appropriate.

The process will build images from the above code using whichever branch you have checked out.

A persistent volume is not being used. All data within the local postgres database is therefore transitory! Any changes will be lost when the container is refreshed!

## Useful commands

* Run an interactive shell session in a pod - ```kubectl exec -it POD-NAME /bin/ash -n take-on```
* Current runtime status of minikube - ```minikube status```
* Reset everything - ```minikube delete``` followed by ```minikube start```
* Access the minikube dashboard - ```minikube dashboard```
* View all the available pods - ```kubectl get pods -ntake-on```
* View all IP & ports for deployed layers - ```minikube service list -ntake-on```
* View container logs - ```kubectl logs <PODNAME> -ntake-on```

## Recommended aliases/functions

* ```alias kubeurl='minikube service list -ntake-on'```
* ```alias allpods='kubectl get pods -ntake-on'```
* ```kubelogs(){ kubectl logs $(kubectl get pods -ntake-on | grep "$1" | awk '{print $1}') -ntake-on}```

kubelogs will look up the appropriate internal pod details and let you view a log by using a unique part of the layer title. i.e.

* ```kubelogs ui```
* ```kubelogs bus```
* ```kubelogs ql```

### Issues/Errors
You can refer to the Common Issues section under 'Linux based systems'. Also the following issues can occur.

| Issue | Cause | Resolution |
|---| --- | --- |
|If you re start minikube, it can allocate a different ip address to the postgres pod. In that case the persistence layer will no longer be able to connect to postgres | Allocation of different ip address to postgres pod by minikube restart | Follow the steps mentioned above for re run|
|UI layer not able to access other services | Service account requires cluster-admin role | Along with step 2 above, the command ```kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=default:default``` can work |
