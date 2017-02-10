# Domain model

All services belong to a domain like **Customer** or **Billing**. Domain name is defined in every startup file and
it's available as a standard service (see [standard services](/reference/injection/#predefined-services))

Services use **domain model**, or **Schema** in vulcain context, to validate input data.

**Schemas** are defined with annotations. Only well defined schema properties will be taken into account when requesting a handler.

Define a schema is really easy.

```ts
@Model()
export class Customer {
    @Property({ type: "string", required: true })
    @Validator("length", { min: 5 })
    firstName: string;
    @Property({ type: "string", required: true, unique: true, isKey: true })
    lastName: string;
}
```

This code define **Customer** model with 2 required properties.

```firstName``` has a length validation and ```lastName``` provides some specific informations for the
default provider implementation.

