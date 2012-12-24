# encoding: utf-8
require 'erb'
require 'json'

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
        hash.merge(deep_merge_hash(default_values, env_values))
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

    # Deep merge on hash.
    #
    # First hash will receive merge from second hash.
    #
    # @param [ Hash ]
    # @param [ Hash ]
    #
    # @return [ Hash]
    #
    # @since 0.0.2
    #
    def deep_merge_hash(hash1,hash2)
      hash2.each_key do |k1|
        if hash1.key?(k1) && hash2[k1].is_a?(Hash)
          deep_merge_hash(hash1[k1],hash2[k1])
        else
          hash1[k1] = hash2[k1]
        end
      end
      hash1
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
