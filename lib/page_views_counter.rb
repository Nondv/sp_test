require_relative 'log_entry_parser'

class PageViewsCounter
  include LogEntryParser

  def initialize(string_counter)
    @string_counter = string_counter
  end

  def add_log_entry(log_entry)
    string_counter.add(log_entry)
  end

  def pages
    string_counter.keys.map { |k| key_to_page(k) }.uniq
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

  attr_reader :string_counter

  def log_entry_to_key(log_entry)
    entry_hash = parse_log_entry(log_entry)
    "#{entry_hash[:path]} #{entry_hash[:ip]}"
  end

  def key_to_page(key)
    key.split.first
  end
end
