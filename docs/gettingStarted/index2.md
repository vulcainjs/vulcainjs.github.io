---
template: home.html
---

### Getting started

**Prerequisites**

- node 6.0 see [this link](https://nodejs.org/en/download/) to install node on your machine.
- docker version > 1.12. See [this link](https://docs.docker.com/engine/installation/) to install docker.
- **vulcain-cli** is not mandatory but can help you to start easily with **vulcain**. Install it with

```bash
npm install vulcain-cli -g
```

**Installing a demo vulcain environment**

* Create a virtual machine with docker-machine

```sh
docker-machine create -d virtualbox --virtualbox-memory 2048 vulcain
```

!!! note
    Machine must have at least 2gb of memory to run ElasticSearch

* Install vulcain-cli like any global npm package with the following command (may needs sudo):

```sh
npm install -g vulcain-cli
```

* Clone the demo scripts repo

```sh
git clone https://github.com/vulcainjs/vulcain-demo.git vulcain-demo
```

* And run the initialisation script with

```sh
cd vulcain-demo
./install-demo.sh
```

You have now a fully operational vulcain environment.

Vulcain UI is available on ```http://$(docker-machine ip vulcain):8080``` with the default credentials admin/vulcain.

### Create your first microservice

> The following commands must be run in the service's root folder with an initialiazed docker context in order to connect
> to vulcain machine. (This is the case if you have run the install-demo script)

```sh
vulcain create service1
```

This command creates a microservice named service1 using a default project template which is a fully functional
CRUD customer service.

!!! info
    Vulcain templates are predefined for [vscode](https://code.visualstudio.com/) or [webstorm](https://www.jetbrains.com/webstorm/).

    The starter template contains a fully functional microservice managing a simple ```Customer```. By default, the
    microservice uses a very basic in-memory provider persisting to disk for testing.
    
**Vulcain** microservice implements CQRS pattern providing two (and only two) kinds of request:

* Command (named action in **vulcain**) requests available with a **POST** http verb.
* Query requests available with a **GET** http verb.

See [documentation](/reference/index.html) for more details.

__For this demo, all handlers (query and actions) are in the same service but it's a best practice to dispatch handlers on separate services.__

You can now edit the code or publish it directly with :

```sh
vulcain publish 1
```

where 1 is a version number (you must increment it every time you publish a new version).

When a microservice is published, **vulcain** automatically assigns a unique port number beginning from 30000 and used to test your microservice. All microservice endpoints follow the same endpoint format (valid only for testing) :

```
http://<host>:<port>/api/<verb>
```

**Test the microservice**

**Vulcain** microservice is auto-descriptive, you can expose its definition () with :

```bash
curl http:$(docker-machine ip vulcain):30000/api/_servicedescription
```

or its dependencies (databases, external http requests, other microservice, configuration properties and npm packages) with:

```bash
curl http:$(docker-machine ip vulcain):30000/api/_servicedependencies
```

By default, the microservice uses a very basic in-memory provider persisting to disk for testing.

