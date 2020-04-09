#!/usr/bin/env ruby

require_relative '../lib/page_views_counter'
require_relative '../lib/string_counter'

counter = PageViewsCounter.new(StringCounter.new)
$<.each_line { |line| counter.add_log_entry(line) }

# TODO: sort
counter.total_views_by_page.each do |page, views|
  puts "#{page} #{views} visits"
end

puts '---------------'

# TODO: sort
counter.unique_views_by_page.each do |page, views|
  puts "#{page} #{views} unique views"
end
