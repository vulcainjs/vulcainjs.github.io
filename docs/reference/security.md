# Authorization

**Vulcain** uses scope to manage authorization.

Every handler must have a scope defined in its annotation. A scope definition can have three kind of value:

| scope | description |
|:-:|-----|
| ? | Anonymous user (not authentified) |
| * | Any authentified user |
| 'name' | A scope name |

> **Vulcain** supports basic, bearer token and api key authentification. Go to [this article](../articles/users) to see how creating an authentication service providing bearer or apikey token for use with **vulcain**.

A scope defined in ```ActionHandler``` or ```QueryHandler``` is a default scope for all handler method but can be override in every method.

You can defined many scope for a same handler by seprating them with a comma.

!!!info
    Security context propagation

    Bearer token is used to propagate along all vulcain service requests the security context. A bearer token is automatically created for every request with basic or api key authentication.

    Each bearer token encapsulates user properties (name, displayName, scopes and tenant) available from the ```requestContext.user``` property.

## Scope definition format

Scope name is composed by the domain service name and the defined name.

For example, the following scope definition in a **Identities** [domain name](./domain) :

```csharp
@ActionHandler({scope:'User:create'})
```

will be named 'identities:user:create'.

> Scope is case insensitive.

A scope defines a hierarchy with a root level (e.g. identities) and sub levels separed by colon.

## Scope rule

When you create a new user, you assign it a list of scope rules. This rules are processed to check if an user is authorized to use an handler.

A rule is compared to a scope and can contains a '*' operator which means all sub levels. For example, the rule 'identities:*' matches all scope beginning with 'identities:'.

'*' is only valid at a level position e.g. 'identi*:' is not valid.

> The rule '*' means __administrator__

!!! warning
    In development mode (local development) scope are ignored.

## Scope description

Every service exposes its description like handler definition, dependencies and its scope. It's a good practice to provide a description for all scope used in a service.

You can do that in the ```startup``` class.

```csharp
defineScopes(scopes) {
    scopes.defineScope("user:create", "Create a new user");
}
```
