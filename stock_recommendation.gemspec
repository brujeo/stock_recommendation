Gem::Specification.new do |s|
  s.name = %q{stock_recommendation}
  s.version = "0.0.1"
  s.authors = ['Leonid Brujev brujev@gmail.com']
  s.date = %q{2018-12-16}
  s.summary = %q{stock_recommendation is the best}
  s.files = [
    "lib/stock_recommendation.rb"
  ]
  s.require_paths = ["lib"]

  # specify any dependencies here
  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'nokogiri'
end