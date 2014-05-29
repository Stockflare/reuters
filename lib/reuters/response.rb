module Reuters
  # This class parses Savon response bodies into more practical
  # accessible objects, by using a recursive strategy for parsing
  # the content. 
  #
  # @note All attributes for XML elements can be accessed via the
  #   attributes accessor.
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