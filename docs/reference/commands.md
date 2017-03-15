# Commands

Command must be used for every I/O request. **Vulcain** Command is a javascript implementation of [Netflix hystrix](https://github.com/Netflix/Hystrix) forked from [hystrixjs](https://bitbucket.org/igor_sechyn/hystrixjs).

**Vulcain** provides three abstract commands :

- ```AbstractHttpCommand``` to encapsulate all http request (other than calling a vulcain service)
- ```AbstractServiceCommand``` to encapsulate all vulcain service call
- ```AbstractProviderCommand``` to encapsulate database actions.

