require 'pry'


file_path = ARGV[0]

parse = Parse.new(file_path)
parse.run

