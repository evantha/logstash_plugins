# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/index_bucket"

describe LogStash::Filters::IndexBucket do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        index_bucket {
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
