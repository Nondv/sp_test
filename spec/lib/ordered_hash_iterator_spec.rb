require 'ordered_hash_iterator'

RSpec.describe OrderedHashIterator do
  it 'allows to iterate over a hash with a custom compare function' do
    hash = { a: 2,
             b: 1,
             c: 10,
             d: 3 }

    asc = described_class.new(->((_, v1), (_, v2)) { v1 <=> v2 })
    asc_result = []
    asc.iterate(hash) { |k, v| asc_result.push([k, v]) }
    expect(asc_result).to eq [[:b, 1], [:a, 2], [:d, 3], [:c, 10]]

    desc = described_class.new(->((_, v1), (_, v2)) { v2 <=> v1 })
    desc_result = []
    desc.iterate(hash) { |k, v| desc_result.push([k, v]) }
    expect(desc_result).to eq [[:c, 10], [:d, 3], [:a, 2], [:b, 1]]
  end
end
