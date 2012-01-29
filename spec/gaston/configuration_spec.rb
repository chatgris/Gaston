# encoding: utf-8
require 'spec_helper'

describe Gaston::Configuration do
  let(:instance) { mock }

  before do
    Gaston.should_receive(:instance).any_number_of_times.and_return(instance)
    instance.should_receive(:store).and_return({})
    Gaston.configure do |config|
      config.files << "my/path"
      config.env = :production
    end
  end

  after do
    Gaston.instance.instance_variable_set("@store", nil)
  end

  it 'should have a files method' do
    Gaston::Configuration.files.should eq(["my/path"])
  end

  it 'should have a env method' do
    Gaston::Configuration.env.should eq(:production)
  end

end
