# Using dynamic properties in vulcain context

**Vulcain** divides properties in two kind :

* Shared properties
* Service properties

Properties can be of any type (string, number,...) but the recommended one is json object associated with a schema.
With [schema](schema), properties can be validated before send to applications. Even if your property has only one value,
it's better to use an object with a simple property.

## Shared properties

This properties are shared along all services