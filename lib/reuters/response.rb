module Reuters
  # This module acts as a Namespace for client-based
  # response classes. For example, the Token client has
  # a corresponding Token response class, which is used
  # to automagically parse responses from the Reuters API.
  class Response < Hash

    attr_accessor :body, :attributes

    def initialize(body = {})
      unless body.empty?
        merge! body
        attribs = body.keep_if { |k| k.match(/@/) }
        attribs = Hash[attribs.map { |k, v| [k.to_s.gsub(/@/, '').to_sym, v] }]
        @attributes = self.class.new attribs
      end
    end

    def method_missing(name)
      if key?(name)
        if (val = self[name]).is_a? String
          val
        else
          self.class.new val
        end
      end
    end

  end
end