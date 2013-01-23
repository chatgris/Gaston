# encoding: utf-8
class Gaston
  class Builder
    class << self
      def new(parent, hash={})
        hash.each_with_object({}) do |(key, store), hsh|
          camelize = Inflecto.camelize(key)
          begin
            klass = Inflecto.constantize("#{parent}::#{camelize}")
          rescue NameError
            klass = parent.const_set Inflecto.camelize(key), Class.new(Hash)
          end
          store = klass[Gaston::Builder.new(klass, store)] if store.is_a?(Hash)
          if parent.instance_methods.include? key.to_sym
            warn "#{key} method already exists on #{parent}, value: #{store}"
          else
            store.tap {|s|
              hsh[key] = s
              parent.send(:define_method, key, -> { s })
            }
          end
        end
      end
    end
  end
end
