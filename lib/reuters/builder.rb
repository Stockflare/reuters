module Reuters
  # This class enables the rapid and relatively painless
  # construction of the body of Reuters API calls.
  #
  # It extends the Hash class, which means that it is
  # compatible with the Savon request call and includes
  # all the basic functionality of a Hash.
  #
  # @note This class is documented with worked examples
  #  on the main README file.
  #
  # @see http://savonrb.com/version2/requests.html
  class Builder < Hash

    def initialize(body = {}, &block)
      self[:attributes!] = {}
      attributes body
      block.call(self) if block
    end

    # Assign element attributes to a specific key inside
    # the hash. All attributes are assigned to the
    # 'hidden' :attributes! key.
    #
    # @example Adding an attribute
    #   req = Reuters::Builder.new
    #   req.attributes(exchange_code: { id: 123 })
    #
    # @param [Hash] attribs to add to the attributes! key.
    # @param [Boolean] camelcase the keys inside the hash?
    #
    # @return [Hash] the resulting hash that was added.
    def attributes(attribs, camelcase = true)
      camelize_keys(attribs).each do |key, value|
        hash = camelcase ? camelize_keys(value) : value
        self[:attributes!][key] ||= {}
        self[:attributes!][key].merge! hash
      end
    end

    # Uses the name of the missing method and adds it
    # as a new key inside this hash. If the method
    # is called as an assignment, the value will be
    # set to the element, otherwise a nested {Builder}
    # is returned.
    def method_missing(name, body = nil, camelcase = true, &block)
      key = camelize name

      if name.match(/\=$/)
        assign_val(key, body)
      else
        assign_body(key, body, camelcase)
      end

      self[key] ||= Reuters::Builder.new(&block) if block
      self[key] ||= Reuters::Builder.new

    end

    # Return all keys inside this Hash object except
    # for the :attributes! key. This key is hidden
    # so that it cannot be mistaken for an XML Element.
    #
    # @return [Array] All keys except for :attributes!
    #   which will always exist.
    def keys
      super - [:attributes!]
    end

    # Attempts to find a key that exists in the hash.
    # If the key cannot be found in its current format,
    # the method attempts to camelcase the key and
    # search again.
    #
    # @return [Boolean] True if the key exists, false otherwise.
    def key?(key)
      super || super(camelize(key))
    end

    # Attempts to find a key that exists within the attributes hash.
    # If the key cannot be found in its current format,
    # the method attempts to camelcase the key and
    # search again.
    #
    # @return [Boolean] True if the key exists, false otherwise
    def attribute_key?(key, attr_key)
      attrs = attribute_keys(key)
      attrs.include?(camelize(attr_key)) || attrs.include?(attr_key)
    end

    # Returns all keys inside the attributes hash.
    #
    # @return [Array] All attribute keys.
    def attribute_keys(key)
      (self[:attributes!][camelize(key)] || {}).keys
    end

    private

    def assign_val(key, body)
      self[key] = body
    end

    def assign_body(key, body, camelcase = true)
      case body
      when Hash
        attributes({ key => body }, camelcase)
      when Array
        self[key] ||= Array.new(body.count) { '' }
        attributes(key => order_attributes(body))
      end
    end

    def order_attributes(attribs)
      keys = attribs.map(&:keys).flatten.uniq
      ordered = {}
      keys.each do |k|
        ordered[k] = []
        attribs.each { |a| ordered[k] << (a[k].to_s || '') }
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
