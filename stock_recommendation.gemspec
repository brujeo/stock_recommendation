Gem::Specification.new do |s|
  s.name = %q{stock_recommendation}
  s.version = "0.0.2"
  s.authors = ['Leonid Brujev']
  s.date = %q{2018-12-16}
  s.summary = %q{A ruby gem that retrieves Buy|Hold|Sell recommendations for the stock from Reuters Analyst Website}
  s.files = [
    "lib/stock_recommendation.rb"
  ]
  s.require_paths = ["lib"]

  # specify any dependencies here
  s.add_development_dependency 'bundler', '~> 1.12'
  s.add_development_dependency 'rake', '~> 12.3.2'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'nokogiri', '~> 1.8.5'
end