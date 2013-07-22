# encoding: utf-8
class Gaston
  class Configuration

    class << self

      attr_accessor :files, :env

      # Define a configure block.
      #
      # @example
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
        default_values!
        yield self
      end

      def env=(env)
        if env
          @env = env
        end
        @env
      end

      private

      # Set default values
      #
      # @since 0.0.1
      #
      def default_values!
        @files = []
        @env = :development
      end

    end # self
  end # Configuration
end #Gaston
