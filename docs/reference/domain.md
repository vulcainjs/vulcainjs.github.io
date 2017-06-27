# Domain model

**Vulcain** respects the [**bounded context**](https://martinfowler.com/bliki/BoundedContext.html) paradigm with the **domain** concept.

All services belong to a domain like **Customer** or **Billing**. Domain name is defined in every startup file.

## What is a domain ?

The main notion with **bounded context** is responsability. It's more a functional notion than a technical implementation. Implementing microservice targeting this concept is your responsability. **Vulcain** just helps you to identify domain in its communication protocol and in event notifications.

But at the level of a microservice, the notion of **domain** is implemented by schema description and validation.

## Using local schema

**Vulcain** provides a mechanism to define **domain model** (or **Schema**). In the context of a **vulcain** microservice, this provides the following functionalities:

- Describe data models used by a microservice and can help generating code or creating microservice description like swagger.
- Validate all input data before calling an handler.
- Transform data during validation process.
- Define some metadata information used by default provider to persist data.
- Transform output data before sending over http

**Schemas** are defined with annotations. All input (handler argument) must be defined even though output argument definition is not mandatory, without it you loose the possibility to generate typed code.

## Defining a schema

Thanks to annotations, defining a schema is really easy.

```ts
@Model()
export class Child {
    @Property({ type: 'string', required: true })
    name: string;
}

@Model({validate: Customer.checkRule1})
export class Customer {
    @Property({ type: 'string', required: true })
    @Validator(SchemaStandardValidators.length, { min: 5 })
    firstName: string;
    @Property({ type: 'string', required: true, unique: true, isKey: true })
    lastName: string;
    @Property({ type: 'string', required: true, type: SchemaStandardTypes.enum, values: ['M', 'F'], bind: Customer.bindSex})
    sex: string;
    @Property({type:'boolean'})
    enabled = true; // Default value
    @Reference({cardinality: 'many', item: 'Child'})
    children: Child[];

    static checkRule1(entity: Customer) {
        if( entity.sex === 'M' && entity.firstName === 'john' && entity.lastName === 'doe')
            return "john doe is not a valid customer";
    }

    static bindSex(val: string) {
        if( val && val.toLowerCase() === 'female')
            return 'F';
        if( val && val.toLowerCase() === 'male')
            return 'M';
    }
}

@Model({ extends: "Customer"})
export class PremiumCustomer extends Customer {
    @Property({type:'number')
    discount: number;
}
```

```@Model``` declares a schema and can contains ```@Property``` and ```@Reference```.

### The @Model annotation

| Option | type | Description | Default value |
|------|-----|---|------|
| name | string | Model name | class name |
| extends | string | extending schema name | null |
| description | string | Schema description | null |
| bind | (entity) => any) or boolean | Transform data from request data | null |
| validate | (entity, ctx?: RequestContext) => string | Custom validation function | null |
| storageName | string | Collection (as in MongoDb) name used by provider | class name |
| hasSensibleData | boolean | This schema has sensible data (see below)| false |

@Model ***extends** is mandatory because there is no way to know if a javascript object inherits from another object (even though your typescript class extends another class). If you omit it, properties of the base class will be ignored.

### The @Property annotation

| Option | type | Description | Default value |
|------|-----|---|------|
| type | string | Property type |  |
| description | string | Property description | null |
| required | boolean | This property is mandatory | false |
| bind | (val, entity) => any) or boolean | Transform data from request data | null |
| validate | (val, ctx?: RequestContext) => string | Custom validate function | null |
| items | string | Item type for ```arrayOf``` type | null |
| values | string | Authorized values for ```enum``` type | null |
| isKey | string | Used by provider | false |
| unique | string | Used by provider | false |
| sensible | string | This property is sensible and will be encrypted and protected (value hidden in logs etc...)| |
| dependsOn | (entity) => boolean | Condition to validate this property | true |

### The @Reference annotation

| Option | type | Description | Default value |
|------|-----|---|------|
| cardinality | 'many' or 'one' | Reference cardinality  | |
| item | string | Target type. Must be a valid schema |  |
| description | string | Reference description | null |
| required | boolean | This reference is mandatory | false |
| bind | (entity) => any) or boolean | Transform data from request data | null |
| validate | (entity, ctx?: RequestContext) => string | Custom validate function | null |
| dependsOn | (entity) => boolean | Condition to validate this reference | true |

> You can use ```any``` for referencing anonymous item.

> Referenced schema must be declared **before** the schema using it a reference (in the sample above **Child** is defined before **Customer**).

## Validation process detail

When an handler is requested, **vulcain** will validate input data before calling the handler processing the following steps:

1. First, bind body data for all schema properties and references.
    - if schema contains a ```bind``` method call it and return its value.
    - else for all properties call its ```bind``` method if any or just take the value property then the declared property default value.
    - call recursivly binding for extended class if any.
    - then do binding for all referencies for any type other than ```any``` otherwise take the full dependency object.

2. Validate bound data with the same strategy by replacing ```bind``` method by ```validate```.

Validate can return a list of error validation message, in this case a 400 Bad Request response is returned containing an ```error``` property with the following format:

```js
"error": {
    "message": "Validation errors",
    "errors": [
        {
            "message": "error message",
            "property": "property name",
            "id": "data id" // Property with a isKey option set to true
        }
    ]
}
```

## Predefined types and validators

A list of predefined types are available using the ```SchemaStandardTypes``` static properties :

- string
- any
- boolean
- number
- integer
- enum : use values to enumerate valid values
- uid : bind to a new uid
- arrayOf : use item to define element type
- range : use min and max property
- email
- url
- alphanumeric
- date-iso8601

## Custom validation method

You can create a custom validation method, it must return an error message or null.

Error message can contain substitution variables defined with the ```{variable_name}``` pattern :

| variable name | description |
|----|-----|
| $value | Current property value |
| $propertyName | Current property name |
| $id | data id |
| $schema | schema name |
| any other name without $ | another property value |


## Validators

A list of predefined validators is available using the ```SchemaStandardValidators``` static properties :

- patternValidator: use pattern to define a pattern
- lengthValidator: use min and max to define length

### Definining custom validator

You can customize a validation method for a specific property with the ```validate``` method but you can also share validation by creating custom validator.

A validator is just a simple class with a ```validate``` method and properties. Properties beginning with a ```$``` will be overridden by options specified by the ```@Validator``` annotation.

For example, the ```length``` validator is defined like this:

```csharp
export class LengthValidator  {
    public type = "string"; // Must be a 'string' type
    public $min = undefined;
    public $max = undefined;

    private static messages = [
        "Property '{$propertyName}' must have at least {$min} characters.",
        "Property '{$propertyName}' must have no more than {$max} characters."
    ];
    validate(val) {
        let len = val.length;
        if (this.$min !== undefined) {
            if (len < this.$min) return this.messages[0];
        }
        if (this.$max !== undefined) {
            if (len > this.$max) return this.messages[1];
        }
    }
}
```

The validator must be registered into the current domain with :

```csharp
const domain = this.container.get<Domain>(DefaultServiceNames.Domain);
domain.addValidator("length", new LengthValidator());
```

And can be used with:

```csharp
    @Validator("length", { min: 5, max: 10 }) // Create a new LengthValidator instance and set $min and $max properties
```
