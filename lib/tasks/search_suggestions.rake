desc "Generate search suggestions for pages"
task :index => :environment do
  SearchSuggestion.index_pages
end

