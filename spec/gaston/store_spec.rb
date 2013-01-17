# encoding: utf-8
require 'spec_helper'

describe Gaston::Store do
  let!(:config) { {:config => 'test', 'config' => 'test'} }
  let(:store) { Gaston::Store.new({:config => 'test'})}
  let(:hash_store) { Gaston::Store.new({:values => 'test'})}
  let(:multi_store) do
    Gaston::Store.new({:nested => {:one => :level, :nested => {:two => ['warp', :zone]},
                       :spk => {:one => :bim}}
    }.merge(config))
  end

  describe 'one level store' do

    context 'existing method' do
      it 'should return value through method' do
        store.config.should eq('test')
      end

      it 'should respond to respond_to?' do
        store.respond_to?(:config).should be_true
      end

    end

    context 'no method' do

      it 'should raise NoMethodError' do
        lambda {
          store.no_method
        }.should raise_error(NoMethodError)
      end

      it 'should not respond to respond_to?' do
        store.config.respond_to?(:no_method).should be_false
      end

    end

  end

  describe "methods defined on Hash" do
    it "should add values method" do
      hash_store.values.should be_empty
    end
  end

  describe 'multi level store' do
    it 'should be a Store' do
      multi_store.nested.should be_a_kind_of Gaston::Store
    end

    it 'should be recursive' do
      multi_store.nested.one.should eq(:level)
      multi_store.nested.nested.two.should eq(["warp", :zone])
    end

    it 'should return bim!' do
      multi_store.nested.spk.one.should eq :bim
    end

  end

  describe 'slice' do
    it 'can be called' do
      multi_store.slice(:config, 'config').should eq(config)
    end
  end

end
