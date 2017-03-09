# Action handler

Action handler is defined with the ```ActionHandler``` and ```Action``` annotations.

The first indicates that a class implements one (or more) action handler. It has two main behaviors : It defines some default configurations used by all handler defined in the class and, it registers the class in the dependency manager.

The latter must be set on every handler method, it can override every properties of the ```ActionHandler``` annotations.

## handler definition

```csharp
@ActionHandler({ async: false, scope: "?", schema: Customer })
export class CustomerActionHandler extends DefaultActionHandler {

    @Action({ description: "Custom action", outputSchema: "string" })
    async myActionAsync() {

    }
}
```

This code defines an action handler and can be requested by ***POST***ing to ```/api/Customer.myaction```.

```Customer.action``` is called ***verb*** following the pattern &lt;schema&gt;.&lt;action name&gt;.

!!! info
    schema can be undefined so the **verb** is simply the action name.

### Action handler properties

| Property | Required | Description | Default |
| --- |: - :| --- |: -- : |
| scope | yes | Define authorization. See how to define [scope](security) | |
| description  | yes | Global definition | |
| schema | | Schema manipulates by the handler. It must be a [domain](./domain) schema  | |
| async | | If true, handler will be process asynchronously | false |
| eventMode | | Define how to raise event when the handler completes | successOnly |
| serviceName | | Name to identify the handler class in the [dependency container](./injection) | class name |
| serviceLifeTime | | Dependency component lifetime | Scoped |
| enableOnTestOnly| | Enable this handler only on test mode | false |

### Handler properties

| Property | Required | Description | Default |
| --- |: - :| --- |: -- : |
| scope |  | Define authorization. See how to define [scope](./security) | from ActionHandler |
| description  | yes | Handler description | |
| action| | Action name | Inferred from the method name (minus Async prefix if any) |
| inputSchema| | argument schema. Must be a [domain](./domain) schema | Argument type |
| outputSchema  | yes | Schema of the return value. It must be a [domain](./domain) schema | |
| schema | | Schema manipulates by the handler. It must be a [domain](./domain) schema  | from ActionHandler |
| async | | If true, handler will be process asynchronously | from ActionHandler |
| eventMode | | Define how to raise event when the handler completes | from ActionHandler |

!!! info
    ```inputSchema```,```outputSchema```and```description``` properties are used for metadata description.

### Standardized protocol

**Vulcain** uses a standardized way for all query and action handlers.

#### Endpoint

All endpoint action address format is ```/api/<verb>``` with ```verb``` equals to &lt;schema&gt;.&lt;action name&gt; and must be called with a ***POST*** http verb.

```verb``` is optional but should be defined within the post body with the ```schema``` and ```action``` properties.

Body must contains a json object with the following format :

| Property | Description |
| -- | -- |
| schema | |
| action | |
| params | |



### Asynchronous action task

