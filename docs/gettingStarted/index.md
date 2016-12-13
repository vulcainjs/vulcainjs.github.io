# Getting started

## Prerequisites

- node 6.0 see [this link](https://nodejs.org/en/download/) to install node on your machine.
- docker version > 1.12. See [this link](https://docs.docker.com/engine/installation/) to install docker.
- **vulcain-cli** is not mandatory but can help you to start easily whith **vulcain**. Install it whith

```js
npm install vulcain-cli -g
```

## Creating a simple microservice

#### Option 1

After installing ***vulcain-cli***, run ```vulcain init my-service```.

#### Option 2

Clone the starter template from ```github``` with

```git clone https://github.com/vulcainjs/vulcain-template-microservice.git my-service```

and replace all '<%= project.fullName %>' project occurences with ```my-service``` and '<%=project.namespace%>' by ```my-domain``` in ```startup.ts```.

## Vulcain concepts

You are ready to run your micro-service. Open the projet with your favorite editor.

> Vulcain template are predefined for using with [vscode](https://code.visualstudio.com/) or [webstorm](https://www.jetbrains.com/webstorm/).

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
