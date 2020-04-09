#!/usr/bin/env ruby

require_relative '../lib/page_views_counter'
require_relative '../lib/string_counter'
require_relative '../lib/ordered_hash_iterator'

counter = PageViewsCounter.new(StringCounter.new)
$<.each_line { |line| counter.add_log_entry(line) }

hash_iterator = OrderedHashIterator.new(->((_, v1), (_, v2)) { v2 <=> v1 })

hash_iterator.iterate(counter.total_views_by_page) do |page, views|
  puts "#{page} #{views} visits"
end

puts '---------------'

hash_iterator.iterate(counter.unique_views_by_page) do |page, views|
  puts "#{page} #{views} unique views"
end
