# encoding: utf-8
require 'spec_helper'

describe Gaston::Parse do
  let(:gaston_file) { file_path('gaston.yml')}
  let(:env_file) { file_path('env.yml')}

  context 'without default values' do
    let(:parse) { Gaston::Parse.new([env_file], :test)}

    it 'should parse with success' do
      parse.to_hash['chuck']['norris'].should eq('facts')
    end
  end

  context 'with default values' do
    let(:parse) {Gaston::Parse.new([gaston_file], :test)}

    it 'should keep default values' do
      parse.to_hash['chuck']['steven'].should eq(:seagal)
    end

    it 'should override default values' do
      parse.to_hash['chuck']['norris'].should eq("prod_api_key")
    end

    it 'should be success' do
      parse.to_hash['spk']['norris'].should eq("bim")
    end
  end
end
