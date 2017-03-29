# Dynamic configuration properties

Configuration properties often require to be updated at runtime without restarting your services.

Dynamic properties offers a simple and easy way to update properties on the fly.

> This is inspired by [Netflix archaius](http://github.com/netflix/archaius).

## Features

* Runtime update. Last values are cached locally.
* Service can be notified when a value changes.
* Property values are pulled from a remote server with a configuration source adapter.
* Many adapters can be used with different protocols (http, consul, file...)
* Properties can be chained, providing a value from a hierachical chain of values.
* Properties can be encrypted and decrypted locally inside a service.
* Supports docker secret

## Concepts

All properties are managed by a `DynamicConfiguration` singleton object.
This is the unique entry point to all dynamic properties and it exposes different static methods for creating, listening and initializing properties.

There are two kind of properties :

| Type | Description |
|-----|-----|
| Service specific | Visible only by a specific Service |
| Shared | Visible by all services |

## Declaring a dynamic property

**Vulcain** provides helpers to create dynamic properties.

To create a shared property:

```ts
let property1 = System.createSharedConfigurationProperty<string>("property-name", "default value");
```

To create a service property:

```ts
let property1 = System.createServiceConfigurationProperty<number>("property-name", 0);
```

These helpers create a *chained* property. Chained property create a pipeline of dynamic properties using the first value available.

For example for a service property, the pipeline consists of the following property names :

1. service name + service version + property name
1. service name + property name
1. property name (= shared property)
1. default value

> You can create your own chained property with ```DynamicConfiguration.asChainedProperty<string>()```.

### Dynamic property value

A property can be initialized from external source, environment variable or docker secret.

External source uses polling to get values. This process is initialized before bootstrapping the application. It uses ```ConfigurationSource``` object pulling data at specific time interval.

**Vulcain** provides many adapters to retrieve values like ```HttpConfigurationSource``` or ```VulcainConfigurationSource```.

> You can see how to create an external service providing values to use with ```VulcainConfigurationSource``` in this [article](../articles/dynamicProperties).

Polling configurations are set in index.ts in the default vulcain template.

```csharp
import { DynamicConfiguration } from "vulcain-corejs";

// Configuration initialization must run first.
DynamicConfiguration
    .init(60) // Polling interval
    .addVulcainSource()
    .startPollingAsync()
    .then(() => { // Waiting for properties initialized
        // Initialization OK
        // Bootstrap application
        // lazy loading to ensure component is loaded only after properties are initialized
        let startup = require("./startup");
        new startup.Startup().runAsync();
    })
    .catch((e: Error) => {
        console.log("Bootstrap error " + e.stack + ". Process stopped");
        process.exit(1);
    });
```

!!! info

    Application starts only after first polling completes successfully. This ensures services can use updated  properties when they are initialized.

Using external sources is optional. Dynamic property can also be initialized with :

* Environment variable with name transforming in uppercase and all specific character replaced with '_'. Exemple a property named ```vulcainSecretKey``` is transformed to ```VULCAIN_SECRET_KEY```.
* [Docker secret key](https://docs.docker.com/engine/swarm/secrets/).

Values are initialized in the following order:

1. External source
1. Environment variable
1. Docker secret file


## Using a dynamic property

You can get a property value through its ```value``` property.

```ts
let value = property1.value;
```

You can subscribe to a specific property value change with ```property1.propertyChanged.subscribe( fn )```.

!!! info
    Dynamic property can not be updated from a service, you can only override the local default value, no update
    will be sent to sources.

## Providing value with environment variable

A default value can be provided by an environnement variable respecting the SCREAMING SNAKE CASE pattern:

* Split property name into words using the camel case rule.
* Use underscore to separate words
* Use only uppercase

E.g. variableName -> VARIABLE_NAME

## Providing values with configuration source

By default, service template uses a vulcain configuration source only valid within vulcain environment.
This is defined in the ``ìndex.ts``` project file. You can replace the default vulcain configuration source by another one.

```csharp
DynamicConfiguration
    .init(60) // Polling interval
    .addFileSource('config.json')   // Read from a configuration file (once)
    .addSource( new HttpConfigurationSource('http://my-config-server'))
    .startPollingAsync()
    .then(() => { // Waiting for properties initialized
        // Initialization OK
        let startup = require("./startup"); // lazy loading
        new startup.Startup().runAsync();
    })
    .catch((e: Error) => {
        console.log("Bootstrap error " + e.stack + ". Process stopped");
        process.exit(1);
    });
```

!!!info
    Sources can be multiple.

    You can also create your own custom ```HttpConfigurationSource``` reading properties from a specific url.
