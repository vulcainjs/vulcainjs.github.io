# Dependency injection

**Vulcain** provides a simple [dependency injection](https://martinfowler.com/articles/injection.html#ConstructorInjectionWithPicocontainer) mechanism supportting ```constructor parameters injection``` and ```Setter injection```

It uses annotations to declare dependencies.

## Declaring components

You can declare component (also called service) with the ```@Injectable``` annotation.

```js
@Injectable(LifeTime.Singleton)
export class MyComponent {}
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
| Singleton | Only one instance will be created |
| Transient | A new instance is always created |
| Scoped    | Singleton instance by request scope |

When service starts, **vulcain** loads all components found in the ```src/api``` folder. You can register components from another folder with the container ```injectFrom``` method.

Also you can inject component manually with the following container methods :

- ```injectTransient```
- ```injectSingleton``` and ```injectInstance```
- ```injectScoped```

In this case, they don't need to be declared with a ```@Injectable``` annotation.

There is two locations to register component both in the ```startup``` class.

- In the ```initializeDefaultServices``` method - This allows you to override default services (like logging service or database provider) used by application services. This method is called before the application bootstrap.
- In the ```initializeServices``` method - This allows you to register custom application service (If not declared in the ```src/api``` folder).

> All handlers are automatically registered as scoped service and available using their class name or ```@xxxxHandler``` serviceName option.

## Using components

As mentioned above, component can be injected as a constructor argument or as a setter property.

### Construction injection

Argument must be annotated with the ```@Inject``` annotation.

```csharp

export class MyClass {
    constructor(@Inject(DefaultServiceNames.Container) container: IContainer, @Inject("MyComponent") myComponent: MyComponent, otherArg: string) {
    }
}

```

The ```@Inject``` annotation has two optionals arguments:

- A name used to specify a specific name declared in the ```@Injectable``` annotation. Default is argument type name.
- A boolean named optional used to not raise an error if the injected component doesn't exist. The default behavior is to raise an exception if the component is unknow.

The following rules are applied :

1. Using ```@Inject``` is mandatory to specify argument injection.
1. You can mix injected arguments with *classic* arguments **however** injected arguments must be declared first.

### Setter injection

Component can be injected into property **after** the constructor is completed.

```csharp

export class MyClass {
    @Inject()
    myComponent: MyComponent;

    constructor(otherArg: string) {}
}

```

If you want to be notified when property injections are completed, you can implement the ```IInjectionNotification``` interface ```onInjectionCompleted``` method. This method is called by the dependency injection engine.


## Component lifetime

To create a component with dependencies, you must instanciate it from the application container. It is available in all handlers and commands from the ```container``` property.

```csharp

container.get("component-name")

```

> Using the ```new``` keyword to instanciate a component will result to unexpected behavior.

### Scoped component

Scoped components are disposed when the request ends. You can provide your own component ```dispose``` method.
All scoped components are initialized with a ```requestContext``` property.

## Default services

Vulcain provides predefined services available with standardized names.
All predefined service names are declared in a static class named ```DefaultServiceNames```

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
| MockManager | Default mock manager
| RequestContext | Current request context
| Metrics | Manage and emit metrics
| ApiKeyService | Service to manage api key
| RequestTracer | Default service tracer (zipkin)
