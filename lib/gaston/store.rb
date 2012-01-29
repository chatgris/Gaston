# encoding: utf-8
class Gaston
  class Store < Hash

    # Initialize Store.
    #
    # @param [ Hash ] Hash config to be stored.
    #
    # @since 0.0.1
    #
    def initialize(hash)
      hash ||= {}
      hash.each do |key, value|
        value.is_a?(Hash) ? self[key] = Gaston::Store.new(value) : self[key] = value
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
      super(method, *args, &block)
    end

    # Implement respond_to?
    #
    # @since 0.0.1
    #
    def respond_to?(method)
      has_key?(method.to_s) || has_key?(method.to_sym) || super(method)
    end

  end # Store
end #Gaston
