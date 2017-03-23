# Authorization

**Vulcain** uses scopes to manage authorization.

Every handler must have a scope defined in its annotation. A scope definition can be any of the following kind:

| scope | description |
|:-:|-----|
| ? | Anonymous user (not authentified) |
| * | Any authentified user |
| 'name' | A scope name |

> **Vulcain** supports basic, bearer token and api key authentification. Go to [this article](../articles/users) to see how to create an authentication service providing bearer or apikey token to use with **vulcain**.

A scope defined in ```ActionHandler``` or ```QueryHandler``` is a default scope for all handler methods but can be overriden in each and every method.

You can define many scopes for a same handler by seperating them with a comma.

!!!info
    Security context propagation

    Bearer token is used to propagate along all vulcain service requests the security context. A bearer token is automatically created for every request with basic or api key authentication.

    Each bearer token encapsulates user properties (name, displayName, scopes and tenant) available from the ```requestContext.user``` property.

## Scope definition format

Scope name is composed by the domain service name and the defined name.

For example, the following scope definition in an **Identities** [domain name](./domain) :

```csharp
@ActionHandler({scope:'User:create'})
```

will be named 'identities:user:create'.

> Scope is case insensitive.

A scope defines a hierarchy with a root level (e.g. identities) and sub levels separed by colon.

## Scope rule

When you create a new user, you assign it a list of scope rules. These rules are processed to check if a user is authorized to use an handler.

A rule is compared to a scope and can contain a '*' operator which means all sub levels. For example, the rule 'identities:*' matches all scopes beginning with 'identities:'.

'*' is only valid at a level position e.g. 'identi*:' is not valid.

> The rule '*' means __administrator__

!!! warning
    In development mode (local development) scope are ignored.

## Scope description

Every service exposes its description like handler definition, dependencies and its scope. It's a good practice to provide a description for all scopes used in a service.

You can do that in the ```startup``` class.

```csharp
defineScopes(scopes) {
    scopes.defineScope("user:create", "Create a new user");
}
```
