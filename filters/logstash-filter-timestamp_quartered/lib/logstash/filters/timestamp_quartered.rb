# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "date"

# This filter will decide the index name based on the date and the gap.
class LogStash::Filters::TimestampQuartered < LogStash::Filters::Base

  # configure this filter from your Logstash config.
  #
  # filter {
  #    {
  #		date_field => "%{raisedTimestamp}"
  #		index_field => "index_name"
  #		gap => 3
  #		index_value => "metrics-"
  #   }
  # }
  #
  # If the date_field is provided, date value represented by that field is 
  # used for calcualtion. If not provided, current date is used.
  # 
  #
  #
  config_name "timestamp_quartered"
  
  # a datetime field of the event
  config :date_field, :validate => :string, :required => false
  # index_field is used to store the new index name
  config :index_field, :validate => :string, :required => false, :default => "index_name"
  # gap in months that an index should fall into
  config :gap, :validate => :number, :required => false, :default => 3
  # value calculated by this filter will be appended to this given index name
  config :index_value, :validate => :string, :required => true
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)
	# extract index_value from actual event
	index_value = event.sprintf(@index_value)

	quarter = get_quarter(event)
	new_index_name = index_value + quarter.to_s
    event.set(index_field, new_index_name)

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
  
  private
  def get_quarter(event)

	if @date_field
		date_field_value = event.sprintf(@date_field)
		date_field = Date.parse(date_field_value) rescue Date.today
	else
		date_field = Date.today
	end
	
	if @gap && (@gap < 1 or @gap > 12)
		@gap = 3
	end

	quarter = (date_field.month / @gap.to_f).ceil
	
	return quarter
  end
  
end # class LogStash::Filters::TimestampQuartered
