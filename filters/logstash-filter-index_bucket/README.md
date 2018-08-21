# index-bucket filter

This filter will decide the index name based on the date and the gap.

## Configuration
In logstash config file,

filter {
      index_bucket {
  			date_field => "%{raisedTimestamp}"
  			index_field => "index_name"
  			gap => 3
  			index_value => "metrics-"
    	 }
   }

## Build your plugin gem
```sh
gem build logstash-filter-timestamp_quartered.gemspec
```

## Install the plugin from the Logstash home
```sh
bin/logstash-plugin install /your/local/plugin/logstash-filter-timestamp_quartered-0.1.0.gem
```