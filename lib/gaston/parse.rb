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
        h = deep_merge(hash, default_values)
        deep_merge(h, env_values)
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

    # _why deep merge
    #
    # @return Hash
    #
    # @since 0.2.1
    #
    def deep_merge(store, other)
      m = proc do |key, o, n|
        if o.is_a?(Hash)
          o.merge(n,&m)
        else
          store[key] = n
        end
      end
      store.merge(other, &m)
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
