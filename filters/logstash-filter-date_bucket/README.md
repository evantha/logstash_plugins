# date-bucket filter

This filter will decide the bucket value based on the date and the gap.

## Configuration
In logstash config file
```sh
filter {
      date_bucket {
  			date_field => "%{date_field}"
  			gap => 3
    	 }
   }
```

## Build your plugin gem
```sh
gem build logstash-filter-timestamp_quartered.gemspec
```

## Install the plugin from the Logstash home
```sh
bin/logstash-plugin install /your/local/plugin/logstash-filter-timestamp_quartered-0.1.0.gem
```