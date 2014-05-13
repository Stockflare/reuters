module Reuters
  module Namespaces
    module Base

      module ClassMethods
        def namespace
          "#{Reuters.namespaces_endpoint}/#{self.name}"  
        end
        def action(key)
          self::Actions.send(key)
        end
      end

      extend ClassMethods

      def self.included klass
        klass.extend(ClassMethods)
      end

      module Actions
      end

    end
  end
end