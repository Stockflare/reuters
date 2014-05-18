module Reuters
  class Builder < Hash

    def initialize(body = {}, &block)
      self[:attributes!] = {}
      self.attributes body
      block.call(self) if block
    end

    def attributes(attribs, camelcase = true)
      camelize_keys(attribs).each do |key, value|
        hash = camelcase ? camelize_keys(value) : value
        self[:attributes!][key] ||= {}
        self[:attributes!][key].merge! hash
      end
    end

    def method_missing(name, body = nil, camelcase = true, &block)
      key = camelize name

      if name.match /\=$/
        assign_val(key, body)
      else
        case body
        when Hash
          self.attributes({ key => body }, camelcase)
        when Array
          self[key] ||= Array.new(body.count) { "" }
          self.attributes(key => order_attributes(body))
        end
      end

      self[key] ||= Reuters::Builder.new &block if block
      self[key] ||= Reuters::Builder.new

    end

    def keys
      super - [:attributes!]
    end

    def key?(key)
      super || super(camelize(key))
    end

    private

    def assign_val(key, body)
      self[key] = body
    end

    def order_attributes(attribs) 
      keys = attribs.collect(&:keys).flatten.uniq
      ordered = {}
      keys.each do |k|
        ordered[k] = []
        attribs.each { |a| ordered[k] << (a[k].to_s || "") }
      end
      ordered
    end

    def camelize(key)
      key.to_s.camelize.gsub(/[^a-z0-9]/i, '')
    end

    def camelize_keys(hash)
      new_hash = {}
      hash.each { |key, val| new_hash[camelize key] = val }
      new_hash
    end

  end
end