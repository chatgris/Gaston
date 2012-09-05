# encoding: utf-8
require 'spec_helper'

describe Gaston do
  before do
    Gaston.configure do |gaston|
      gaston.env = :test
      gaston.files = Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.yml')].sort
    end
  end

  it 'should return api_key from api config from Gaston constant' do
    Gaston.api.provider.should eq(:bing)
  end

  it 'should be success' do
    Gaston.chuck.norris.should eq "prod_api_key"
  end

  it 'should be success' do
    Gaston.spk.norris.should eq "bim"
  end
end
