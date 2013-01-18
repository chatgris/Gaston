# encoding: utf-8
class Gaston
  class Store < Hash

    # Initialize Store.
    #
    # @param [ Hash ] Hash config to be stored.
    #
    # @since 0.0.1
    #
    def initialize(hash={})
      hash.each do |key, value|
        if hash.respond_to? key
          warn "#{key} method already exists on Hash, value: #{value}"
        else
          value.is_a?(Hash) ? self[key] = self.class.new(value) : self[key] = value
        end
      end
    end

    # Search into store for value.
    #
    # @param [ String || Symbol ] key store.
    #
    # @since 0.0.1
    #
    def method_missing(method, *args, &block)
      return self[method.to_s] if has_key? method.to_s
      return self[method.to_sym] if has_key? method.to_sym
      super
    end

    def slice(*keys)
      hash = {}
      keys.each {|method|
        hash[method] = self[method.to_s] if has_key? method.to_s
        hash[method] = self[method.to_sym] if has_key? method.to_sym
      }
      hash
    end

    # Implement respond_to?
    #
    # @since 0.0.1
    #
    def respond_to?(method)
      has_key?(method.to_s) || has_key?(method.to_sym) || super
    end

  end # Store
end #Gaston
