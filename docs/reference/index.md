# Documentation

**Documentation is in progress**

**Vulcain** is a new microservice framework. It provides a way to create easily full operational microservices by normalizing i/o protocol, metrics and logging.

Every **vulcain** microservice encapsulates metadata description allowing to use external tools for generating code, services cartography, monitoring...

**Vulcain** implements natively some major well-know patterns like DDD, CQRS, hystrix command, dynamic configuration, dependency injection and event sourcing.

It targets the nodejs V6 (or more) platform and leverages all typescript functionalities like annotations, async/await, reflection...

## Major functionalities

- Standardizes request and response HTTP format
- Generate metrics for every request
- Standardizes logging format with data obfuscation for sensible data.
- Services are organized by domain and separate Query request from action (command) request.
- Validate input data.
- Request context propagation on every service request.


### Main concepts

The first concept to understand how **vulcain** works is ```handler```. There is three kind of handler:

- Query handler can not manipulate data and has side effect, it just returns data.
- Action handler can modify data and can be asynchrone. Every action raises an event when it completes.
- Event handler subscribes to event. Event can be filtered by domain, action, schema and any more.

This a basic schema showing how it works:

<img src="../images/vulcainjs-schema.png" width="500px">

