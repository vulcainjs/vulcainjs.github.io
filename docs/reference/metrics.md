# Metrics and logging

**Vulcain** generates many metrics and logging informations formatted to be used directly with well-know tools.

## Logging

- Log are json formated and are emit directly to the console to levearage docker logging plug-in.
- Every log contains a correlationId propagated along vulcain service requests.

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

> To be used with the fluentd docker log driver.

## Metrics

**Vulcain** emit metrics for every request and command. It provides natively an ```statsd``` exporter.

To activate metrics, just define an environment variable ```STATSD_AGENT``` set with the stasd agent address.

This is a sample configuration file to use with ```telegraf```

```js
[global_tags]

[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  debug = false
  quiet = false
  hostname = ""
  omit_hostname = false

[[outputs.influxdb]]
  urls = [$INFLUXDB_SERVERS]
  database = "$ENV"
  precision = "s"
  retention_policy = "default"
  write_consistency = "any"
  timeout = "5s"
  username = "$INFLUXDB_USER"
  password = "$INFLUXDB_PASSWORD"

# Read metrics about cpu usage
[[inputs.cpu]]
  percpu = false
  totalcpu = true
  fielddrop = ["time_*"]

# Read metrics about disk usage by mount point
#[[inputs.disk]]
  # mount_points = ["/"]
  #ignore_fs = ["tmpfs", "devtmpfs"]

# Read metrics about disk IO by device
#[[inputs.diskio]]

# Get kernel statistics from /proc/stat
#[[inputs.kernel]]

# Read metrics about memory usage
[[inputs.mem]]

# Get the number of processes and group them by status
#[[inputs.processes]]

# Read metrics about swap memory usage
#[[inputs.swap]]

# Read metrics about system load & uptime
#[[inputs.system]]

# # Read metrics about docker containers
[[inputs.docker]]
   endpoint = "unix:///var/run/docker.sock"
#   container_names = []

# Statsd server
[[inputs.statsd]]
  ## Address and port to host UDP listener on
   service_address = "0.0.0.0:8125"
  ## Delete gauges every interval (default=false)
   delete_gauges = false
  ## Delete counters every interval (default=false)
   delete_counters = true
  ## Delete sets every interval (default=false)
   delete_sets = false
  ## Delete timings & histograms every interval (default=true)
   delete_timings = true
  ## Percentiles to calculate for timing & histogram stats
   percentiles = [90]

  ## separator to use between elements of a statsd metric
   metric_separator = "_"

  ## Parses tags in the datadog statsd format
  ## http://docs.datadoghq.com/guides/dogstatsd/
  parse_data_dog_tags = false

# Number of UDP messages allowed to queue up, once filled,
# the statsd server will start dropping packets
   allowed_pending_messages = 10000
#
  ## Number of timing/histogram values to track per-measurement in the
  ## calculation of percentiles. Raising this limit increases the accuracy
  ## of percentiles but also increases the memory usage and cpu time.
  percentile_limit = 1000
```
