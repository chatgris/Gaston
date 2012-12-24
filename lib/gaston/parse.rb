# encoding: utf-8
require 'erb'
require 'json'
require 'gaston/core_ext/hash/deep_merge'

class Gaston
  class Parse

    # Initialize Parsing.
    #
    # @param [ Array ] List of yaml files.
    # @param [ Symbol ] Environment.
    #
    # @since 0.0.2
    #
    def initialize(files, env)
      @env = env
      @hash = files.inject({}) do |hash, file|
        parse(file)
        hash.deep_merge(default_values).deep_merge(env_values)
      end
    end

    # @return [ Hash ]
    #
    # @since 0.0.2
    #
    def to_hash
      @hash
    end

    private

    # Default values from yaml.
    #
    # @return [ Hash ]
    #
    # @since 0.0.2
    #
    def default_values
      @parse[:gaston] || {}
    end

    # Env values from hash.
    #
    # @return [ Hash ]
    #
    # @since 0.0.2
    #
    def env_values
      @parse[@env] || {}
    end

    # Parse yaml or json file.
    #
    # @param [ String ]
    #
    # @return [ Hash ]
    #
    # @since 0.2.0
    def parse(file)
      erb = ERB.new(File.read(file)).result
      if File.extname(file) == '.json'
        @parse = JSON.parse(erb, :symbolize_names => true) || {}
      else
        @parse = YAML.load(erb) || {}
      end
    end
  end
end
