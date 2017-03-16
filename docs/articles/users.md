# Creating an user service

**Vulcain** uses [scopes](../reference/security) to manage authorization but this is only valid if you authentify users.

In this article, we will create a service for managing users. It will provide the following features:

- Manage user defined in a basic extensible user model
- Generate bearer token for use with vulcain service.
- Optionaly can manage api key.

## Initializing the project

Let's start from an empty vulcain project.

```sh
vulcain new --template NodeMicroService users-service
```

Then open the project and remove the src/sample folder.

## Add users management functionalities

For this, we will just add a dependency npm package with:

```sh
npm i vulcain-users --save
```

This package contains all functionalities, we need then to declare it as services. Go to startup.ts and :

- Add import statement

```csharp
import * as users from "vulcain-users";
```

- Declare services by adding the following line in ```initializeDefaultServices```

```csharp
users.useUserManagement(container);
```

That is. You have a fully user and apikey service management. You can see all exposed handlers with http://localhost:8080/api/_servicedescription.

## Creating a new user

First we need to create a new admin user with all authorizations by settings its scope to '*'.

```sh
curl -XPOST http://localhost:8080/api/user.create -u admin:admin -H "Content-Type: application/json" \
-d '{"name":"admin", "password":"password", "scopes":["*"]}'
```

!!!info
    For this first request, we have used admin/admin as authentified user. This is the default user with all admin rights if **NO** user exists in the database.
    
    As soon as you create an user, this admin/admin authentication stops to be valid (but you can create a new one with the same name).

We can now test authentication and authorization by trying the following requests:

```sh
curl http://localhost:8080/api/user.all -I
curl http://localhost:8080/api/user.all -I -u admin:admin
curl http://localhost:8080/api/user.all -I -u admin:password
curl http://localhost:8080/api/user.all -u admin:password
```

> Note how admin:admin is no longer valid.

## Creating a bearer token

A bearer token is used to authentify user. Its typically created when an user logs into a web site. It will be valid for all other vulcain service.

```sh
curl http://localhost:8080/api/createToken -XPOST -u admin:password
```

The response must be like this:

```sh
{"tenant":"vulcain","action":"createToken","domain":"identities","status":"Success","correlationId":"fd3a945dcb9146538713f9a351ec9378","value":{"expiresIn":1200,"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXV9.eyJ2YWx1ZSI6eyJ1c2VyIjp7ImRpc3BsYXlOYW1lIjoiYWRtaW4iLCJuYW1lIjoiRtaW4iLCJ0ZW5hbnQiOiJ2dWxjYWluIn0sInNjb3BlcyI6WyIqIl19LCJpYXQiOjE0ODk2NjQxNzEsImV4cCI6MTQ4OTYTM3MX0.J8kVMGqFyQr_j0M2J4dSB0fxfyFLJgcQCuD2by1Bk","renewToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXJ9.eyJpYXQiOjE0ODk2NjQxNsImV4cCI6MTQ4OTY2NTM3MX0.A4tuPF1En_eD53TcMApbweEYtKC-lqq2Zc0lOkavKzI"}}
```

You can now use this token directly

```sh
curl http://localhost:8080/api/user.all -H 'Authorization: Bearer <your token>'
```

## Renewing a token

You can renew a bearer token to extend its expiration time. For this you must use the renewToken provided when your create the token.

> Obviously you need to renew a token before its expiration.

```sh
curl http://localhost:8080/api/renewToken -H 'Authorization: Bearer <your bearer token>' -XPOST -d '{"renewToken": "<your renew token>"}' -H 'Content-Type: application/json'
```

For more informations about using token read [this](https://auth0.com/blog/refresh-tokens-what-are-they-and-when-to-use-them)

### How to specify a custom secret key for production

**Vulcain** uses a default secret key to create token. If you want to deploy **vulcain** service in production you **MUST** provide a new secret key.

This secret key must be share by all service using bearer token. The best way to share a property is to use a [dynamic property](../reference/configurations). But like all dynamic properties you can simply use an environment variable.

Three properties can be defined:

| Property name | Environment variable | description |
|----|---|---|
| vulcainSecretKey | VULCAIN_SECRET_KEY | Secret key |
| vulcainTokenIssuer | VULCAIN_TOKEN_ISSUER | Token issuer |
| vulcainTokenExpiration | VULCAIN_TOKEN_EXPIRATION | Token expiration (default 20m) |

> Under the hood, **vulcain** uses [jsonwebtoken](https://github.com/auth0/node-jsonwebtoken).

## Creating apikey

Apikey can be created with the ```apikey.create``` verb (see service description for details) and can be used like a bearer token by replacing the ```Authorization: Bearer <token>``` by ```Authorization: ApiKey <apikey>```

Apikey has no expiration time and must be revoked with the ```apikey.delete``` verb.

Since apikey validation process needs to access apikey data, if you want to use apikey authentication in another service, you must specify how to access to the user service by adding the following line in ```initializeDefaultServices```.

```csharp
  this.enableApiKeyAuthentication("users-service"); // Set with the name of the users service
```

## Extending default user model

**Vulcain** uses a default user model, you can extend or replace it in your users service by adding a new user model.

To extends the default user model, add this file into the src/api hierarchy.

```csharp
import { User } from "vulcain-users";
import { Model, Property } from "vulcain-corejs";

@Model({ name: 'User', extends: '+User' })
export class MyUser extends User {
    @Property()
    age: number;
}
```

The thing to note is the ```extends``` syntax with a '+' prefix before the model to extend. This means inherit and extend an existing model and replace it with this new model.

To replace an existing model with a new one, use ```extends: "-User"``` instead.

> Be carefull with that, you must implement all default model behaviors like password protection.
