# Testing microservice

A big challenge with microservice is testing integration with others services and dependencies.

**Vulcain** provides many features to help testing in this context.

## Mock functionality

**Vulcain** can create __mock__ by registering a request and saving it in a **session**. When a **session** is registered, you can replay it many times. You can create many **session** given them a different name.

### Registering a mock

To register a __mock session__, you must call a microservice with the specific header ```x-vulcain-register-mock-session``` specifying the session name. 

```html
x-vulcain-register-mock-session: mocksessionname
```

When a microservice endpoint is called with its header, it will save the calling context (action and parameters) and the result.

> By default, a mock session is saved in the '.vulcain' file but you can create your own session manager by overriding the ```MockManager``` default service.

A mock is replayed if the call context (action and parameters) is strictly equals to the registered mock context. If you want to be less restrictive, you can remove some arguments to the saved session, the filter will operate only on existing arguments.

By default, the mock session header is propagated along requests registering mock for all 'sub' services. If you want to limit the scope of the registering session to some specific services, you can include in the mock header a service name filter (as a regular expression).

Example to register a mock session for all services with a name beginning with customer:

```html
x-vulcain-register-mock-session: mocksessionname:^customer
```

!!!info
    Since mock session are saved in the .vulcain file which will be included in the docker container, you can save mock session locally before deploying your microservice.
    In all cases, mock functionality is disabled in production mode.

### Using a mock

You can use a mock session by using the ```x-vulcain-use-mock-session``` header specifying the session name to use. If no session exists, this header is ignored and the microservice runs normally.

> This header supports the filter mechanism.

### Using dynamic properties

Setting request header is not so easy in particular if you don't want to modify your code. So you can enable mock session with [dynamic properties](./configurations). Since dynamic properties can be initialized with environment variables it's easy to use it.

| Property name | Alternate environment variable |
|---|---|
| vulcainUseMockSession | VULCAIN_USE_MOCK_SESSION |
| vulcainRegisterMockSession | VULCAIN_REGISTER_MOCK_SESSION |

> Service dynamic property is valid only for a specific service and don't need a filter. It is not propagated along requests.

## Local development

Sometimes you want to mock not existing (yet) service or an external api for testing your service locally. You can simulate calls using local mock defined in the .vulcain file.

You could define mocks for service (requesting with a ```AbstractServiceCommand```) or for external api (requesting with a ```AbstractHttpCommand```).

> For database, you can use the ```MemoryProvider```.

### Service local mocking

Add definitions in the '.vulcain' file with the following format:

#### Defining an external api mock

```js
{
   "mocks": {
        "http": {
            "<url>": {
                "<http verb>": { // optional
                    "output": {<result body>},
                    "latency": <ms> // optional
                }
            }
        }
    }
}
```

The first url equality wins.

#### Defining a service mock

```js
{
   "mocks": {
        "services": {
            "<service name>": {
                "<service version>": { // optional
                    "service verb": {<service value response>}
               }
           },
           "<service name>": {
                "<service version>": { // optional
                    "service verb": [
                        {
                            "input": { <input args>},
                            "output": {<service value response},
                            "latency": <ms>  // optional
                        },
                        {
                            "input": { <other input args>},
                            "output": {<service value response},
                            "latency": <ms>  // optional
                        }
                    ]
                }
           }
       }
   }
}
```

The first input (or null) matching wins.
