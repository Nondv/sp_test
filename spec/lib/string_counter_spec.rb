require 'string_counter'

RSpec.describe StringCounter do
  it 'keeps count of String data added with #add exposing numbers with #count' do
    instance = described_class.new
    instance.add('abc')
    instance.add('abc')
    instance.add('Abc')
    instance.add('def')

    expect(instance.count('abc')).to eq 2
    expect(instance.count('Abc')).to eq 1
    expect(instance.count('def')).to eq 1
    expect(instance.count('xyz')).to eq 0
  end

  it 'raises a TypeError when key is not String' do
    instance = described_class.new

    expect { instance.add(:abc) }.to raise_error(TypeError)
    expect { instance.count(:abc) }.to raise_error(TypeError)
    expect { instance.add(123) }.to raise_error(TypeError)
    instance.add('123')
  end

  it '#keys returns all unique keys added' do
    instance = described_class.new
    instance.add('abc')
    instance.add('abc')
    instance.add('Abc')
    instance.add('def')

    expect(instance.keys).to match_array ['abc', 'Abc', 'def']
  end
end
