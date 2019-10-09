# takeon-local-kube
Running the takeon UI & associated services locally using minikube




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
* **-d**: Path to the directory containing the postgres Dockerfile
* **-p**: Path to the directory containing the persistence layer Dockerfile
* **-u**: Path to the directory containing the ui layer Dockerfile
* **-b**: Path to the directory containing the business layer Dockerfile

With those the script should run and create a local minikube environment for you to play with.

### Manual Parts
Unfortunately there is one part of this whole process that needs manual input, that is, the running of the entry script. To do this, we need to ssh into the container and run the script that's already there. Some instructions are provided in the script, but we give a small overview here.
```bash
kubectl exec -it POD-NAME /bin/ash -n take-on
```
This will allow us to run an interactive shell session in the database container, the ```POD-NAME``` part is genereated at runtime, and will be given in the terminal, in the shell session we just created run the following:
```bash
./entry.sh
```
This runs our shell script passing in the username and password for the database. Both of these are generated at run time and will be provided by the run_services script.

This section really shouldn't exist, but I'm having trouble running the entrypoint script directly from the docker file, for the life of me I can't work out why.
### Common Issues
There are a couple of known problems that can occur.

| Issue | Cause | Resolution |
|---| --- | --- |
|[VM_DOES_NOT_EXIST] Error getting state for host: machine does not exist | Exiting the setup process while VBox is starting | ```minikube delete``` then start again|
|GraphQL says "No role exists for ```<LETTERS>```" | The entry script in the database layer wasn't run | Run the entry script, after you will likely need to restart the GraphQL service. Run ```kubectl delete <graph-ql-pod-name> -n take-on``` a new pod should start immediately|

## Mac based systems
This section gives the steps to create a local environment in Mac so that all the 3 layers of takeon project namely persistence-layer, business-layer and ui-layer can be run.
### Prerequisites
It requires minikube. If minikube is not already installed, install minikube with ```brew cask install minikube```. Please note before installation of minikube, VirtualBox should already be installed. VirtualBox can be installed with - ```brew cask reinstall virtualbox```.
The images of each layer should already be created locally from the respestive git repo against 'Your docker id' with command ```docker build -t <Your docker id>/takeon-dev-pl:v1 .```
### Steps for first run
1. Check if minikube is running with ```minikube status```. If it is not running run it with ```minikube start```. It can take more than a minute to start minikube.
2. This step is required only in the first time run to grant access to service account so that it can access services from other pods. For this you can go to **mac** dir and run ```kubectl apply -f ../linux/service.yml```
3. This step is required only in the first time run to use the right values for environment variables defined under **env** file under **mac** dir.
4. Install postgres in minikube container by running ```./postgres.sh``` under **mac** dir. In the first time run, you will need to change the permission of the file with ```chmod +x postgres.sh```. After running the ```./postgres.sh``` command, check for the status of the postgres pod. If it is not running, check its status with ```kubectl get pods -o wide```.
5. Now you can install all the layers by running ```./layers.sh``` under **mac** dir. In the first time run, you will need to change the permission of the file with ```chmod +x layers.sh``` before running it. After running the ```./layers.sh``` command, it will give the url of the UI. You can access the url in a browser. Please note, till now data is not loaded.
6. To load the testdata, you can run ```./testdata/test-data.sh``` under **mac** dir. In the first time run, you will need to change the permission of the file with ```chmod +x ./testdata/test-data.sh```. Now you can go to the url given at step 5 to access the App and check against the test data loaded.

In case of re run, you can delete the service and layers with ```./delete-layers.sh``` under **mac** dir. Then you can run ```./postgres.sh``` and ```./layers.sh``` under mac dir. Finally you can run ```./testdata/test-data.sh```. If you are not deleting the postgres deployment, the testdata will still be available from the previous run.

### Issues/Errors
You can refer to the Common Issues section under 'Linux based systems'. Also the following issues can occur.

| Issue | Cause | Resolution |
|---| --- | --- |
|If you re start minikube, it can allocate a different ip address to the postgres pod. In that case the persistence layer will no longer be able to connect to postgres | Allocation of different ip address to postgres pod by minikube restart | Follow the steps mentioned above for re run|
|UI layer not able to access other services | Service account requires cluster-admin role | Along with step 2 above, the command ```kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=default:default``` can work |

### logs
Once the minikube is started, you can access the dashboard with ```minikube dashboard``` command. Then going to pod section, you can view the logs.
You can also get the running pods with ```kubectl get pods```. Then you can see the log of respective pod with command ```kubectl log <POD_NAME>```
