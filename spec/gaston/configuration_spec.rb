# encoding: utf-8
require 'spec_helper'

describe Gaston::Configuration do

  before do
    Gaston.configure do |config|
      config.files << "my/path"
      config.env = :production
    end
  end

  it 'should have a files method' do
    Gaston::Configuration.files.should eq(["my/path"])
  end

  it 'should have a env method' do
    Gaston::Configuration.env.should eq(:production)
  end

end
