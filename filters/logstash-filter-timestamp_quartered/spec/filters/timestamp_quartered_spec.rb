# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/timestamp_quartered"

describe LogStash::Filters::TimestampQuartered do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        timestamp_quartered {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject).to include("message")
      expect(subject.get('message')).to eq('Hello World')
    end
  end
end
