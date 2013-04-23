require 'benchmark'
require_relative "../lib/gaston"

n = 1000000

Gaston.configure do |gaston|
  gaston.env = :test
  gaston.files = Dir[File.join(File.dirname(__FILE__), '../spec/fixtures/**/*.yml')].sort
end

Benchmark.bm do |x|
  x.report {
    n.times do
      Gaston.spk.norris
    end
  }
end
