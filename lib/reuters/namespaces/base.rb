module Reuters
  module Namespaces
    module Base

      module ClassMethods
        def endpoint
          "#{Reuters.namespaces_endpoint}/#{self.name}"  
        end
        def action(key)
          self::Actions.send(key)
        end
        def action_endpoint(key)
          "#{endpoint}/#{action(key)}"
        end
        def configure
          yield self
        end
        def actions
          yield self::Actions
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