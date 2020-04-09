class StringCounter
  def initialize
    # could become a `storage` abstraction for external DB
    # although I think in that case it's easier to create another counter class
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
