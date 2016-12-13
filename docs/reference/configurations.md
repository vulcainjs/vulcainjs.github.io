# Dynamic configuration properties

Configuration properties often need to be update during runtime without restarting your service.

Dynamic properties offers a simple and easy way to update properties on the fly.

*Inspired by [Netflix archaius](http://github.com/netflix/archaius).*

## Features

* Runtime update. Last values are caching locally.
* Service can be notified when a value changes.
* Property values are pulling from remote server with configuration source adapter.
* Many adapters can be used with different protocols (http, consul, file...)
* Properties can be chained, providing a value from a hierachic chain of value.
* Properties can be encrypted and decrypted locally inside service.

## Concepts

All properties are managed by a `DynamicConfiguration` object instanciated as a singleton.
This object is the unique entry point to all dynamic properties.
It exposes different static methods for creating, listening and initializing properties.

Property values are updated with `ConfigurationSource` object pulling data at specific interval.

There are two kind of properties :

1. Service specific : Visible only from a specific Service
1. Shared : View by all services

## Using a dynamic property

**Vulcain** provide helpers to create property.

To create a shared property:

```js
let property1 = System.createSharedConfigurationProperty<string>("property-name", "string", "default value");
```

To create a service property:

```js
let property1 = System.createServiceConfigurationProperty<number>("property-name", "number", 0);
```

The latter create a *chained* property. Chained property create a pipeline of dynamic property using the first value
available.

For example for a service property, the pipeline consists of the following property names :

1. service name + service version + property name
1. service name + property name
1. property name (= shared property)
1. default value
1. Environment variable (as property name in uppercase and all '.' replaced by '_')

> You can create your own chained property with ```DynamicConfiguration.asChainedProperty<string>()```.

You can get property value with its ```value``` property.

```js
let value = property1.value;
```

> Dynamic property can not be updated from a service, you can override a value but only locally, no update
will be send to the different sources.

## Providing values with configuration source

By default, service template uses a vulcain configuration source valid only within vulcain environement.

But you can create a custom ```HttpConfigurationSource``` reading properties for a specific url.

