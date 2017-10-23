## Overview

Configuration properties often need to be updated during runtime without restarting the application. Dynamic properties
 can be updated remotely and propagated to all running applications easily.

This framework is inspired by [Netflix archaius](http://github.com/netflix/archaius).


## Features

* Properties can be updated at runtime. Last values are cached locally.
* Application can be notified when a value changes.
* Property values are pulled from remote server with configuration source adapter.
* Many adapters can be used in an application using multiple protocols (http, consul, file...)
* Properties can be chained, providing a value to a hierachical chain of values.

## Concepts

`DynamicProperty` object encapsulates value which are accessible from the `value` property.

All properties are managed by a `DynamicConfiguration` singleton object.
This object is the unique entry point to all dynamic properties.
It exposes different static methods for creating, listening and initializing properties.

Property values are updated with `ConfigurationSource` object pulling data at specific time intervals.

> Dynamic property can not be updated from a microservice, you can only override a value locally, no update
will be sent to the different sources.

## How to use it

#### First, initialize configuration sources and wait for the first polling to complete

This must be the entry point of your application.
Because your code can consume property values, you must wait for all properties to be initialized.

``` js
DynamicConfiguration.init() // Prepare the property manager
    .addSource(....)        // Add specific configuration source
    .startPollingAsync()    // Start polling
    .then( () => {
        let app = require("application entry point"); // Lazy load application code
        app.run();          // Run you code
    });
```

> Note how this app is started **after** the first polling is complete.
This ensures that dynamic properties will be up-to-date when you load them for the first time.

#### Instanciate a dynamic property

The easiest way is to use static methods from helper `DynamicConfiguration`.

```js
let myProperty = DynamicConfiguration.getProperty<string>(0, 'myProperty');
```

This method accepts an optional third parameter which is a callback function invoked when the property value has changed more info [here](configurations/properties)

#### Use its value

To get the current value, use `value` directly from the `myProperty` variable. You can call it as often as required without performance drawback as a dynamic property is always local and does not make any remote requests.
