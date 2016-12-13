## Overview

Configuration properties often need to be update during runtime without restarting the application. Dynamic properties
 can be updated remotely and propageted to all running applications easily.

This framework is inspired by [Netflix archaius](http://github.com/netflix/archaius).


## Features

* Properties can be updated on runtime. Last values are caching locally.
* Application can be notified when a value changes.
* Property values are pulling from remote server with configuration source adapter.
* Many adapters can be used in an application implementing different protocols (http, consul, file...)
* Properties can be chained, providing a value from a hierachic chain of value.

## Concepts

`DynamicProperty` object encapsulates value which are accessible from the `value` property.

All properties are managed by a `DynamicConfiguration` object instanciated as a singleton.
This object is the unique entry point to all dynamic properties.
It exposes different static methods for creating, listening and initializing properties.

Property values are updating with `ConfigurationSource` object pulling data at specific interval.

> Dynamic property can not be updated from an application, you can override a value by only locally, no update
will be send to the different sources.

## How to use It

#### First, initialize configuration sources and wait for the first polling is completed

This must be the entry point of your application.
Because your code can consume property values, you must wait for all properties initialized.

``` js
DynamicConfiguration.init() // Prepare the property manager
    .addSource(....)        // Add specific configuration source
    .startPollingAsync()    // Start polling
    .then( () => {
        let app = require("application entry point"); // Lazy load application code
        app.run();          // Run you code
    });
```

> Note how your code are loading **after** the first polling are complete.
This ensures that dynamic properties will be up to date when you load them for the first time.

#### instanciate a dynamic property

The must simpler way is to use the static helper methods from `DynamicConfiguration`.

To create a simple dynamic property, use `asProperty` with a default value and a name.

```js
let myProperty = DynamicConfiguration.asProperty<string>(0, 'myProperty');
```

This method accept an optional third parameter as a callback function called when the property value has changed more info [here](configurations/properties)

#### use its value

To get the current value, use `value` directly from the `myProperty` variable. You can call it many time without penalities, a dynamic property is always
local and do not make remote requests.
