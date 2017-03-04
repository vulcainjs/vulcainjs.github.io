# Dependency injection

**Vulcain** provides a simple dependency injection mechanism limited to ```constructor parameters injection```

It uses annotations to declare dependencies.

## Declaring services

You can declare service with the ```@Injectable``` annotation.

```js
@Injectable(LifeTime.Singleton)
export class Service1 {}
```

```Injectable``` accepts three parameters:

| name | required | |
|-----|----------|-|
| lifeTime | yes | Service life time can be ```Singleton```, ```Scoped``` or ```Transient``` |
| service name | false | default to class name |
| enableInTestOnly | false | Register this service only in test mode (default false) |

with **lifeTime**

| name | Description |
|------|-------------|
| Singleton | Only one instance will be created |
| Transient | A new instance is always created |
| Scoped    | Singleton instance by request scope |

## Using services

As mentioned above, dependency injection only works with constructor with ```@Inject``` annotation.

```js

export class MyClass {
    constructor(@Inject("Service1") myService: Service1) {}
}

```

The following rules are applied :

1. Using ```@Inject``` is mandatory to specify parameter injection.
1. You can mix injected parameters with *classic* parameters however injected parameters must be declared first.
1. When service starts, all services defined in the following folders are automatically registered : api/handlers,
api/models, api/services and api/commands.
1. Scoped services are disposed when the request ends. You can provide your own ```dispose``` method.
1. All scoped services are initialized with a ```requestContext``` property.

Service can be created manually using ```container.get("service-name")```.

Also you can inject service manually with the following container methods :

- ```injectTransient```
- ```injectSingleton``` and ```injectInstance```
- ```injectScoped```

## Predefined services

Vulcain provides predefined services available with standardized names.
All predefined service names are defined in a static class named ```DefaultServiceNames```

| name | service |
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
| ProviderFactory | Service to use for creating providers
| TestUser | Default test user in test environment
| RequestContext | Current request context
| Metrics | Manage and emit metrics
| ApiKeyService | Service to manage api key
