# encoding: utf-8
class Gaston
  class Builder
    class << self
      def new(parent, hash={})
        hash.each_with_object({}) do |(key, store), hsh|
          if store.is_a?(Hash)
            camelize = "Gaston" + Inflecto.camelize(key)
            klass = if parent.const_defined? camelize, false
              Inflecto.constantize("#{parent}::#{camelize}")
            else
              parent.const_set camelize, Class.new(Gaston::HashProxy)
            end
            store = klass[Gaston::Builder.new(klass, store)]
          end
          if parent.instance_methods.include? key.to_sym
            warn "#{key} method already exists on #{parent}, value: #{store}"
          else
            hsh[key] = store
            parent.send(:define_method, key, -> { store })
          end
        end
      end
    end
  end
end
