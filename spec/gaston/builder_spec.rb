# encoding: utf-8
require 'spec_helper'

describe Gaston::Builder do
  class GastonSpecer
  end

  class HashStore < Hash
  end

  let!(:store) { Gaston::Builder.new(GastonSpecer, {:config => 'test'})}
  let!(:hash_store) { Gaston::Builder.new(HashStore, {:values => 'test'})}
  let!(:multi_store) do
    Gaston::Builder.new(GastonSpecer, {:config => 'test',
                       :nested => {:one => :level, :key => :value, class: 'this', :nested => {:two => ['warp', :zone]},
                       :spk => {:one => :bim}
    }
    })
  end

  describe 'one level store' do
    context 'existing method' do
      it 'should return value through method' do
        GastonSpecer.new.config.should eq('test')
      end

      it 'should respond to respond_to?' do
        GastonSpecer.new.respond_to?(:config).should be_true
      end

    end

    context 'no method' do
      it 'should raise NoMethodError' do
        lambda {
          GastonSpecer.new.no_method
        }.should raise_error(NoMethodError)
      end

      it 'should not respond to respond_to?' do
        GastonSpecer.new.config.respond_to?(:no_method).should be_false
      end

    end

  end

  describe "methods defined on Hash" do
    it "should add values method" do
      HashStore.new.values.should be_empty
    end
  end

  describe 'multi level store' do
    it 'should be recursive' do
      GastonSpecer.new.nested.one.should eq(:level)
      GastonSpecer.new.nested.nested.two.should eq(["warp", :zone])
    end

    it 'should return bim!' do
      GastonSpecer.new.nested.spk.one.should eq :bim
    end
    
    it "should not conflict with keywords" do
      GastonSpecer.new.nested.should have_key(:class)
    end
    
    it "should not conflict with Hash instance methods" do
      GastonSpecer.new.nested.should have_key(:key)
    end
  end
end
