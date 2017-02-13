# Getting started

## Prerequisites

- node 6.0 see [this link](https://nodejs.org/en/download/) to install node on your machine.
- docker version > 1.12. See [this link](https://docs.docker.com/engine/installation/) to install docker.
- **vulcain-cli** is not mandatory but can help you to start easily whith **vulcain**. Install it with

```bash
npm install vulcain-cli -g
```

## Installing a demo vulcain environment ?

* Create a virtual machine with docker-machine

```sh
docker-machine create -d virtualbox --virtualbox-memory 2048 vulcain
```

!!! note
    Machine must have at least 2gb of memory for running elasticsearch

* Install vulcain-cli like any global npm package with the following command :

```sh
npm install -g vulcain-cli
```

!!! warning
    You may need sudo to run this command.

* Clone the demo scripts repo

```sh
git clone https://github.com/vulcainjs/demo-scripts.git vulcain-demo
```

* And run the initialisation script with

```sh
cd vulcain-demo
./install-demo.sh
```

!!! success
    You have now a fully operationnel vulcain environment.

    Vulcain ui is available on ```http://$(docker-machine ip vulcain):8080``` with admin/vulcain.

## Create your first microservice

!!! note
    The following commands must be run in the service's root folder and docker context initialized to connect
    to vulcain machine. (This is the case if you have run the install-demo script)

```sh
vulcain create service1
```

This command creates a microservice using a default project template which consists as a fully functional
customer service providing CRUD handlers.

!!! tip
    For this demo, all handlers (query and actions) are in the same service but it's a best practice to
    dispatch handlers on separate services.

You can edit the code or publish it directly with

```sh
vulcain publish 1
```

where 1 is a version number, you must increment it every time you'll publish a new version.

!!! info
    Vulcain template are predefined for using with [vscode](https://code.visualstudio.com/) or [webstorm](https://www.jetbrains.com/webstorm/).

    The starter template contains a fullly founctional micro-service for managing a simple ```Customer```. By default, the
    microservice uses a very basic in-memory provider persisting on disk for testing.
