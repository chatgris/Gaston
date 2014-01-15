# encoding: utf-8
require 'spec_helper'

describe Gaston::HashProxy do
  describe "initialising" do
    context "::[]" do
      subject { Gaston::HashProxy[:key, 'value'] }
      it "should initialize like a normal Hash" do
        subject.should eq(:key => 'value')
      end
    end
    context "::new" do
      subject { Gaston::HashProxy.new }
      it "should initialize like a normal Hash" do
        subject.should eq({})
      end
    end
    context "::new with arguments" do
      subject { Gaston::HashProxy.new{ |h,k| h[k] = k > 1 ? h[k-1] * k : 1 } }
      it "should initialize like a normal Hash" do
        subject[5]
        subject.should eq(1 => 1, 2 => 2, 3 => 6, 4 => 24, 5 => 120)
      end
    end
  end
  describe "reading" do
    subject { Gaston::HashProxy[:one, 'two', :three, 'four', :key, 'value'] }
    context "via #[]" do
      it "should work" do
        subject[:one].should eq('two')
      end
    end
    context "via method missing" do
      it "should work for methods not defined on Hash" do
        subject.one.should eq('two')
      end
      it "should work for methods defined on Hash" do
        subject.key.should eq('value')
      end
    end
  end
end
