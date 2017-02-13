# Getting started

## Prerequisites

- node 6.0 see [this link](https://nodejs.org/en/download/) to install node on your machine.
- docker version > 1.12. See [this link](https://docs.docker.com/engine/installation/) to install docker.
- **vulcain-cli** is not mandatory but can help you to start easily whith **vulcain**. Install it whith

```bash
npm install vulcain-cli -g
```

## Installing a demo vulcain environment ?

* Create a virtual machine with docker-machine

```sh
docker-machine create -d virtualbox --virtualbox-memory 2048 vulcain
```

> Note: Machine must have at least 2gb of memory for running elasticsearch

* Install vulcain-cli like any global npm package with the following command :

```sh
npm install -g vulcain-cli
```

> May need sudo.

## Clone the demo scripts repo

```sh
git clone https://github.com/vulcainjs/demo-scripts.git vulcain-demo
```

## Run the initialisation script with

```sh
cd vulcain-demo
./install-demo.sh --host vulcain
````

**You have now a fully operationnel vulcain environment.**

Vulcain ui is available at http://(docker-machine ip vulcain):8080 with admin/vulcain.

Try to create your first microservice :

```sh
vulcain create service1
```

This command creates a microservice using the NodeMicroService template which consists as a fully functional
customer service providing CRUD handlers.

> For this demo, all handlers (query and actions) are in the same service but it's a best practice to
> dispatch handlers on separate services.

You can edit the code or publish directly this service with

```sh
vulcain publish 1
```

> This command must be run in the service's root folder and docker context initialized to connect
> to vulcain machine. (This is the case if you have run the install-demo script)

1 is a version number, you must increment it every time you'll publish a new version.

## Creating a simple microservice

#### Option 1

After installing ***vulcain-cli***, run ```vulcain init my-service```.

#### Option 2

Clone the starter template from ```github``` with

```git clone https://github.com/vulcainjs/vulcain-template-microservice.git my-service```

and replace all '<%= project.fullName %>' project occurences with ```my-service``` and '<%=project.namespace%>' by ```my-domain``` in ```startup.ts```.

## Vulcain concepts

You are ready to run your micro-service. Open the projet with your favorite editor.

!!! info
    Vulcain template are predefined for using with [vscode](https://code.visualstudio.com/) or [webstorm](https://www.jetbrains.com/webstorm/).

The starter template contains a fullly founctional micro-service for managing a simple ```Customer```. By default, the
microservice uses a very basic in-memory provider persisting on disk for testing.

A vulcain micro-service uses the following concepts :

#### Requests are not in REST

Micro-services communicate with a RPC like protocol over HTTP by using only two HTTP verbs:

1. ```GET``` : for query (list or unique)
1. ```POST```: for action

Responses are standardized and http code is limited to 200, 401, 403, 500.


```js

@ActionHandler({ async: false, scope: "*", schema: Customer })
export class CustomerActionHandler extends DefaultActionHandler {

    @Action({ description: "Custom action", outputSchema: "Customer" })
    myActionAsync(customer: Customer): Promise<Customer> {

        const cmd = await this.requestContext.getCommandAsync("MyHystrixCommand", this.metadata.schema);
        return cmd.executeAsync(customer);
    }
}

```
