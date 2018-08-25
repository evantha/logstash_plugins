# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "date"

# This filter will decide the bucket value based on the date and the gap.
class LogStash::Filters::DateBucket < LogStash::Filters::Base

  # configure this filter from your Logstash config.
  #
  # filter {
  #    date_bucket {
  #			date_field => "%{date_field}"
  #			gap => 3
  #  	 }
  # }
  #
  # If the date_field is provided, date value represented by that field is 
  # used for calcualtion. If not provided, current date is used.
  # 
  #
  #
  config_name "date_bucket"
  
  # a datetime field of the event
  config :date_field, :validate => :string, :required => false
  # gap in months that an index should fall into
  config :gap, :validate => :number, :required => false, :default => 3
  

  public
  def register
    # Add instance variables 
	@event_field = "date_bucket_value"
  end # def register

  public
  def filter(event)
	quarter = get_quarter(event)
    event.set(@event_field, quarter.to_s)

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
end # class LogStash::Filters::DateBucket
