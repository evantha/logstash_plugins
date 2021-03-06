Gem::Specification.new do |s|
  s.name          = 'logstash-filter-index_bucket'
  s.version       = '0.1.0'
  s.licenses      = 'Nonstandard'
  s.summary       = 'index field is bucketed based on the date'
  s.authors       = 'Evantha'

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_development_dependency 'logstash-devutils'
end
