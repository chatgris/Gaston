# encoding: utf-8
require 'yaml'
require 'singleton'

class Gaston
  include Singleton
  require 'gaston/configuration'
  require 'gaston/store'

  # Parse yml config files, merge them, and store into
  # gaston::Store
  #
  # @since 0.0.1
  #
  def store
    @store ||= Gaston::Store.new (files.inject({}) {|hash, config|
      parse = YAML.load_file(config)[env]
      hash.merge(parse) if parse
    })
  end

  class << self

    def retrieve
      self.instance.store
    end

    # Define a configure block.
    #
    # Delegates to Gaston::Configuration
    #
    # @example Define the option.
    #   Gaston.configure do |config|
    #     config.env = :test
    #     config.files = Dir[Rails.root.join("config/libraries/**/*.rb"]
    #   end
    #
    # @param [ Proc ] block The block getting called.
    #
    # @since 0.0.1
    #
    def configure(&block)
      Gaston::Configuration.configure(&block)
    end
  end # self

  private

  # List config files.
  #
  # @since 0.0.1
  #
  def files
    Gaston::Configuration.files
  end

  # Current enironment.
  #
  # @since 0.0.1
  #
  def env
    Gaston::Configuration.env.to_sym
  end

end # Gaston
