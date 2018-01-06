require 'yaml'

module Wishwundergram
  class ConfigReader
    attr_accessor :config
    class << self
      private

      def create_methods(items)
        items.each do |item|
          define_singleton_method item.downcase do
            @config[item]
          end
        end
      end

      def load_config
        @config = YAML.safe_load(File.read('config/config.yml'))
      end
    end
    create_methods load_config.keys
  end
end
