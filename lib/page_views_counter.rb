class PageViewsCounter
  def initialize(string_counter, log_entry_parser)
    @string_counter = string_counter
    @log_entry_parser = log_entry_parser
  end

  def add_log_entry(log_entry)
    string_counter.add(log_entry_to_key(log_entry))
  end

  def total_views_by_page
    string_counter.keys.each_with_object({}) do |key, result|
      page = key_to_page(key)
      result[page] ||= 0
      result[page] += string_counter.count(key)
    end
  end

  def unique_views_by_page
    string_counter.keys.each_with_object({}) do |key, result|
      page = key_to_page(key)
      result[page] ||= 0
      result[page] += 1
    end
  end

  private

  attr_reader :string_counter, :log_entry_parser

  def log_entry_to_key(log_entry)
    entry_hash = log_entry_parser.parse_log_entry(log_entry)

    "#{entry_hash[:path]} #{entry_hash[:ip]}"
  end

  def key_to_page(key)
    key.split.first
  end
end
