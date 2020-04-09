#
# Streams key+val pairs in order defined by comparing function `compare_fn`
class OrderedHashIterator
  # `compare_fn` is something like: -> ((k1, v1), (k2, v2)) { v1 <=> v2 }
  def initialize(compare_fn)
    @compare_fn = compare_fn
  end

  def iterate(hash)
    compare_keys = ->(k1, k2) { @compare_fn.call([k1, hash[k1]], [k2, hash[k2]])  }
    hash.keys.sort(&compare_keys).each { |k| yield(k, hash[k]) }
  end
end
