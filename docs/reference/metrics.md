# Metrics and logging

**Vulcain** generates many metrics and logging informations formatted to be used directly with well-know tools.

## Logging

Log are json formated and are emit directly to the console to levearage docker logging plug-in.

You can emit log with the ```RequestContext``` log property available in every scoped component (handler or command) with the ```requestContext```property. Another way to log information is to use directly the static ```System.log``` property.

### Using fluentd with vulcain

Here a simple fluentd configuration to send all logs to an elasticsearch database.

```xml
<source>
  @type  forward
</source>

<filter vulcain.**>
  @type parser
  format json
  key_name log
  reserve_data false
</filter>

<match vulcain.**>
  @type elasticsearch
  host "#{ENV['ELASTIC_URL']}"
  port "#{ENV['ELASTIC_PORT']}"
  logstash_format
  logstash_prefix "logs-#{ENV['VULCAIN_ENV']}"
  flush_interval 15s
</match>
```

> You must use the fluentd docker driver 