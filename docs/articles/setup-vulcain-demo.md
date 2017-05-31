# How to setup Vulcain Demo on an Azure Virtual machine

## Prerequisites
To follow this **How-to** you need a valid Azure Subscription and `docker-machine` installed 

## Get your Azure subscription
On the Azure portal get your Azure subscription ID

## Create Docker VM with `docker-machine`
Execute the following command to setup a docker machine on Azure:
```
docker-machine create -d azure --azure-ssh-user <user-name> --azure-subscription-id <azure-subscription-id> --azure-resource-group <optional-resource-group-name> --azure-location <optional-azure-location> --azure-open-port 80 <machine-name>
```
All parameters and default values are available [here](https://docs.docker.com/machine/drivers/azure/#options)


## Check the 'docker-machine' environment
Run the following command to display the 'docker-machine' environment configuration

```
docker-machine env <machine-name>
```

Which should result to something like this on **Windows**
```
$Env:DOCKER_TLS_VERIFY = "1"
$Env:DOCKER_HOST = "tcp://<vm-ip>:2376"
$Env:DOCKER_CERT_PATH = "<path>"
$Env:DOCKER_MACHINE_NAME = "<machine-name>"
$Env:COMPOSE_CONVERT_WINDOWS_PATHS = "true"
# Run this command to configure your shell:
# & "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env <machine-name> | Invoke-Expression
```
## Deploy vulcain-demo images
Clone the following repository from [github vulcain-demo](https://github.com/vulcainjs/vulcain-demo.git)

`git clone https://github.com/vulcainjs/vulcain-demo.git`

On **Windows** you'll need to run `./install-demo.ps1 --hostName <machine-name>` script from the root directory using **PowerShell**

Once everything is setup you should see the following message

> Vulcain UI is available at http://\<machine-ip>\:8080 user: admin/vulcain

## Post install configuration
If you wish to stop and start the Vulcain VM you may endup with a different IP address. You can setup a DNS entry for this machine from the Azure portal on your VM public ip blade (\<machine-name>-ip) under configuration / DNS name label
> This way you can access **vulcain-ui** with an address like:<br/>
> **https://\<dns-label>.\<azure-region>.cloudapp.azure.com:8080**

You may also use this address in your **vulcain-cli** configuration
