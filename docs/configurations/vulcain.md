# Using dynamic properties in vulcain context

**Vulcain** divides properties in two kinds :

* Shared properties
* Service properties

Properties can be of any type (string, number,...) but it is recommended to use a json object associated to a schema.
With [schema](schema), properties can be validated before being sent to applications. Even if your property has only one value,
it's better to use an object with a simple property to benefit from builtin schema validation.

## Shared properties

These properties are shared accross all services