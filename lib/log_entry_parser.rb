# frozen_string_literal: true

module LogEntryParser
  class ParsingError < StandardError; end

  module_function

  def parse_log_entry(log_entry)
    parts = log_entry.split(/\s+/).reject(&:empty?)

    raise ParsingError unless parts.size == 2

    { path: parts[0],
      ip: parts[1] }
  end
end
