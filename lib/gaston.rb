# encoding: utf-8
require 'yaml'
require 'singleton'

class Gaston
  include Singleton
  require 'gaston/configuration'
  require 'gaston/store'
  require 'gaston/parse'
  if defined?(Rails)
    require 'gaston/generators/gaston/config_generator'
  end

  # Parse yml config files, merge them, and store into
  # gaston::Store
  #
  # @since 0.0.1
  #
  def store
    @store ||= Gaston::Store.new(hash_from_files)
  end

  class << self

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
      self::Configuration.configure(&block)
      self.instance.store.each do |key, value|
        define_singleton_method key do
          value
        end
      end
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

  # Return one merged hash from yaml config files.
  #
  # @return [ Hash ]
  #
  # @since 0.0.2
  #
  def hash_from_files
    @hash_from_files ||= Gaston::Parse.new(files, env).to_hash
  end

end # Gaston
