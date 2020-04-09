class StringCounter
  def initialize
    @hash = {}
  end

  def add(key)
    raise TypeError unless key.is_a?(String)

    hash[key] ||= 0
    hash[key] += 1
  end

  def count(key)
    raise TypeError unless key.is_a?(String)

    hash[key] || 0
  end

  def keys
    hash.keys
  end

  private

  attr_reader :hash
end
