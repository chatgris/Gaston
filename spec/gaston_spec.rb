# encoding: utf-8
require 'spec_helper'

describe Gaston do
  before do
    Gaston.configure do |gaston|
      gaston.env = :test
      gaston.files = Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.yml')]
    end
  end

  it 'should return api_key from api config from Gaston constant' do
    Gaston.api.provider.should eq(:bing)
  end
end
