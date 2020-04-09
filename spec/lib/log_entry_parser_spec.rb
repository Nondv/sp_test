require 'log_entry_parser'


RSpec.describe LogEntryParser do
  let(:parsing_error) { LogEntryParser::ParsingError }

  def subject(log_entry)
    described_class.parse_log_entry(log_entry)
  end

  it 'converts a line from a log file (<path> <ip>) to a hash' do
    expect(subject('/about 127.0.0.1')).to eq(path: '/about', ip: '127.0.0.1')
    expect(subject('/users/123 123.1.2.3')).to eq(path: '/users/123', ip: '123.1.2.3')
  end

  it 'treats /something and /something/ as different paths' do
    expect(subject('/users/ 127.0.0.1')[:path]).to eq '/users/'
    expect(subject('/users 127.0.0.1')[:path]).to eq '/users'
  end

  describe 'input validation' do
    it 'checks that input has only two parts: path and ip' do
      expect { subject('/about 127.0.0.1 Chrome') }.to raise_error(parsing_error)
      expect { subject('/about') }.to raise_error(parsing_error)
    end

    it 'ignores whitespace characters between parts and surrounding' do
      expectation = { path: '/about', ip: '127.0.0.1' }

      expect(subject('/about 127.0.0.1')).to eq(expectation)
      expect(subject('/about   127.0.0.1')).to eq(expectation)
      expect(subject(" /about \t\t 127.0.0.1 ")).to eq(expectation)
      expect(subject(" /about 127.0.0.1\t ")).to eq(expectation)

      expect { subject(" /ab\tout 127.0.0.1") }.to raise_error(parsing_error)
    end

    pending 'raises an error if path is a url, not a path?'
    pending 'raises an error if multiline?'
  end
end
