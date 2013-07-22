# encoding: utf-8
require 'spec_helper'

describe Gaston do
  before do
    Gaston.configure do |gaston|
      gaston.env = :test
      gaston.files = Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.yml')].sort
    end
  end

  it "should be in :test env" do
    Gaston::Configuration.env.should eq :test
  end

  it "should not set env to nil" do
    Gaston::Configuration.env = nil
    Gaston::Configuration.env.should_not be_nil
  end


  it "should not set env to :development" do
    Gaston::Configuration.env = :development
    Gaston::Configuration.env.should eq :development
  end
end
