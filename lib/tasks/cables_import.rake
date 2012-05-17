require 'csv'

namespace :cables do
  
  desc "hello world"
  task :hello do
    puts "Hello World!" 
  end
  
  desc "Import cables data from CSV file"
  task :import => :environment  do
    path = ENV.fetch("CABLES_CSV") do
      File.join(File.dirname(__FILE__), *%w[.. .. db data cables.csv])
    end
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      Cable.create(row.to_hash)
    end
  end
  
end
