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
        self[key] = value.is_a?(Hash) ?  Gaston::Store.new(value) : hash[key]

        self.class.instance_eval do
          define_method key do
            value.is_a?(Hash) ?  Gaston::Store.new(value) : hash[key]
          end
        end
      end
    end

  end # Store
end #Gaston
