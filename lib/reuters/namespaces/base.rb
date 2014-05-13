module Reuters
  module Namespaces
    module Base

      module ClassMethods
        def namespace
          "#{Reuters.namespaces_endpoint}/#{self.name}"  
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