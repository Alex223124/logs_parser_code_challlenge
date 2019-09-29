require 'pry'
require_relative 'parse'
require_relative 'visit'
require_relative 'page'
require_relative 'report'
require_relative 'statistics'


file_path = ARGV[0]

if file_path
  parse = Parse.new(file_path)
  parse.run

  types = ["webpages_with_most_page_views", "webpages_with_most_unique_page_views"]
  report = Report.new(types, parse.pages)

  report.run
  puts report.result
end
