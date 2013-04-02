# encoding: utf-8

class Gaston
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Gaston initializer"

      def copy_initializer
        directory "gaston", "config/gaston"
        template "_gaston.rb", "config/initializers/_gaston.rb"
      end
    end
  end
end
