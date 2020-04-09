require 'page_views_counter'
require 'string_counter'
require 'log_entry_parser'

RSpec.describe PageViewsCounter do
  def init
    described_class.new(StringCounter.new, LogEntryParser)
  end

  it '#total_views_by_page' do
    counter = init
    counter.add_log_entry('/about 127.0.0.1')
    counter.add_log_entry('/about 127.0.0.10')
    counter.add_log_entry('/about 127.0.0.1')
    counter.add_log_entry('/about 127.0.0.1')

    counter.add_log_entry('/about/ 127.0.0.1')

    counter.add_log_entry('/users/1 127.0.0.100')
    counter.add_log_entry('/users/1 127.0.0.1')
    counter.add_log_entry('/users/1 127.0.0.10')

    expect(counter.total_views_by_page).to eq('/about' => 4, '/about/' => 1, '/users/1' => 3)
  end

  it '#unique_views_by_page' do
    counter = init
    counter.add_log_entry('/about 127.0.0.1')
    counter.add_log_entry('/about 127.0.0.10')
    counter.add_log_entry('/about 127.0.0.1')
    counter.add_log_entry('/about 127.0.0.1')

    counter.add_log_entry('/about/    127.0.0.1')

    counter.add_log_entry('/users/1 127.0.0.100')
    counter.add_log_entry('/users/1 127.0.0.1')
    counter.add_log_entry('/users/1 127.0.0.10')
    counter.add_log_entry('/users/1 127.0.0.100')
    counter.add_log_entry('/users/1 127.0.0.100')

    expect(counter.unique_views_by_page).to eq('/about' => 2, '/about/' => 1, '/users/1' => 3)
  end

  it 'raises errors on invalid input' do
    counter = init
    error = LogEntryParser::ParsingError
    expect { counter.add_log_entry('/about 127.0.0.1 Chrome') }.to raise_error(error)
  end
end
