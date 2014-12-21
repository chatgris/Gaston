# encoding: utf-8
class Gaston
  class HashProxy < BasicObject
    
    # Route all class methods to initialize self with a
    # hash initialized by wildcard arguments
    #
    class << self
      def method_missing(method, *args, &block)
        HashProxy.new(::Hash.send(method, *args, &block))
      end
    end
    
    # Initialize the Hash Proxy with wildcard arguments
    # If the first argument is a hash, which is not standard Hash
    # initialization, assign it as the proxied hash
    #
    def initialize(*args, &block)
      super()
      @hash = if args.first.is_a?(::Hash)
        args.first
      else
        ::Hash.new(*args, &block)
      end
    end
    
    # There are two possible cases:
    # 1) When proxied hash has some stored value for the method symbol / string, return that
    # 2) Otherwise, route the missing method to the proxied hash
    # This allows every possible value to be stored in the hash
    #
    def method_missing(method, *args, &block)
      if @hash.has_key?(method)
        @hash[method]
      elsif @hash.has_key?(method.to_s)
        @hash[method.to_s]
      elsif @hash.has_key?(method.to_sym)
        @hash[method.to_sym]
      else        
        @hash.send(method, *args, &block)
      end
    end
    
    # Send has the same possibilities as method missing
    #
    alias :send :method_missing
    
    # undefine == since it is defined on BasicObject
    # and does not make sense for this implementation
    #
    undef :==
        
  end
end
