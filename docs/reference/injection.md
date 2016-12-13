# Dependency injection

**Vulcain** provides a minimalist dependency injection mechanism limited to ```constructor parameters injection```

It uses annotations to declare dependencies.

## Declaring components

You can declare component with the ```@Injectable``` annotation.

```js
@Injectable(LifeTime.Singleton)
export class Component1 {}
```

```Injectable``` accepts three parameters:

| name | required | |
|-----|----------|-|
| lifeTime | yes | Component life time can be ```Singleton```, ```Scoped``` or ```Transient``` |
| component name | false | default to class name |
| enableInTestOnly | false | Register this component only in test mode (default false) |

with **lifeTime**

| name | Description |
|------|-------------|
| Singleton | Only one instance will be created
| Transient | A new instance is always created
| Scoped    | Singleton instance by request scope

## Using components

As already saw, dependency injection only works within constructor with ```@Inject``` annotation.

```js

export class MyClass {
    constructor(@Inject("Component1") myComponent: Component1) {}
}

```

The following rules are used :

1. Using ```@Inject``` is mandatory to specify parameter injection.
1. You can mix injected parameter with *classic* parameter but injected parameters must be declared first.
1. When service start, all components defined in the following folders are automatically registered : api/handlers,
api/models, api/services and api/commands.
1. Scoped components are disposed when the request ends. You can provide your own ```dispose``` method.
1. All scoped components are initialized with a ```requestContext``` property.

Component can be created manually using ```container.get("component-name")```.

Also you can inject component manually with the following container methods :

- ```injectTransient```
- ```injectSingleton``` and ```injectInstance```
- ```injectScoped```

## Predefined components

Vulcain provides predefined components availables with standardized names.
All predefined component names are defined in a static class named ```DefaultServiceNames```

| name | component |
|------|-----------|
| Container | Current container (global) or scoped in requestContext
| TenantPolicy | Policy used to resolve TenantPolicy
| AuthorizationPolicy | Policy used to check authorization from ScopesDescriptor
| TokenService | Service to manage jwt token
| ScopesDescriptor | Metadata service for describing all scopes used in the current service
| ServiceDescriptors | Metadata service for describing all service handlers
| Authentication | Default authentication service
| Logger | Default logger
| Provider | Default provider (do not use it directly - Use ProviderFactory instead)
| EventBusAdapter | Event bus adapter
| ActionBusAdapter | Action bus adapter
| Domain | Current domain definition
| Application | Current application context
| ServerAdapter | Current server adapter (default express adapter)
| ProviderFactory | Service to use for creating provider
| TestUser | Default test user in test environnement
| RequestContext | Current request context
| Metrics | Manage and emit metrics
| ApiKeyService | Service to manage api key

