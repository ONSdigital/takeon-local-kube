# takeon-local-kube
In this repo you'll find some basic scripts for running the takeon microservices locally using minikube

## Linux based systems
### Prerequisites
Before continuting you'll need to have local copies of the most recent UI, Business and Persistence layers. Along with those, you'll also need the postgres.yml file.
### Linux based systems
In the linux folder you'll find a bash script that you can run. First you'll need to give it executable permissions, do this by running 
```bash 
sudo chmod +x run_services.sh
```
Once that has been changed run the script by doing
```bash
./run_services.sh -d [path] -p [path] -u [path] -b [path]
```
The 4 command line arguments are:
* **-d** : Path to the postgres.yml file
* **-p** : Path to the directory containing the persistence layer Dockerfile
* **-u** : Path to the directory containing the ui layer Dockerfile
* **-b** : Path to the directory containing the business layer Dockerfile

With those the script should run and create a local minikube environment for you to play with.

### Common Issues
There are a couple of known problems that can occur.

| Issue | Cause | Resolution |
|---| --- | --- |
|[VM_DOES_NOT_EXIST] Error getting state for host: machine does not exist | Exiting the setup process while VBox is starting | ```minikube delete``` then start again|
|kubectl logs reports that service account can't access "services" in a namespace other than _default_ | In the UI we parameterised the namespace option, but didn't expose a way to change it without altering code | In kubernetes_discovery.kubernetes_config.py replace ```self.namespace = namespace``` with ```self.namespace = default``` |
|peristence layer reports psql connection error | Missing credentials | Make sure that database username and password has been added to your environment


