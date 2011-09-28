# encoding: utf-8
require 'spec_helper'

describe Gaston do
  let(:gaston) { Gaston.retrieve }

  before do
    Gaston.configure do |config|
      config.env = :test
      config.files = Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.yml')]
    end
  end

  it 'should be a Gaston::Store' do
    gaston.should be_a_kind_of Gaston::Store
  end

  it 'should return api_key from api config' do
    gaston.api.provider.should eq(:bing)
  end
end
