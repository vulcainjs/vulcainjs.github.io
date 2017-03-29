# Documentation

**Documentation is in progress**

**Vulcain** is a microservice framework. It provides a way to easily create fully operational microservices running in docker container by normalizing i/o protocol, metrics and logging.

Every **vulcain** microservice encapsulates its own metadata description allowing to use external tools for generating code, services cartography, monitoring...

**Vulcain** natively implements some well-know patterns like DDD, CQRS, hystrix command, dynamic configuration, dependency injection and event driving development.

It targets Nodejs V6 (or more) platform and leverages all typescript functionalities such as annotations, async/await, reflection...

## Main features

- Uses typescript annotations to declare endpoints.
- Standardized request and response HTTP format
- Generate metrics for every request (zipkin, statsd)
- Standardized logging format with data obfuscation for sensible data.
- Services are organized by domain and separate query request from action (command) request.
- Automatic input data validation
- Request context propagation (security, correlation id) on every service request.
- Uses hystrix command to encapsulate all i/o (http, database, service communication, ...)
- Fully extensible thanks to dependency injection.
- Provides default adapters to quickly start with mongodb, zipkin, rabbitmq...

### Main concepts

This a basic schema showing how a **vulcain** service works:

<img src="../images/vulcainjs-schema.png" width="500px">

#### Handler

The first concept to understand how **vulcain** works is ```handler``` which define service endpoint. There is three kind of handler:

- **Query** handler can not manipulate data and has no side effect, it just returns data.
- **Action** handler can modify data and can be asynchronous. Every action raises an event once it completes.
- **Event** handler subscribes to event. Event can be filtered by domain, action, schema and any more.

#### Command

Another important concept is **Command** which encapsulates all i/o access. 

