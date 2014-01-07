json.array!(@pages) do |page|
  json.extract! page, :id, :person, :person_id
  json.url page_url(page, format: :json)
end
