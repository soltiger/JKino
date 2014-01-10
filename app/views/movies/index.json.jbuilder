json.array!(@movies) do |movie|
  json.extract! movie, :id, :movie_name, :movie_url
  json.url movie_url(movie, format: :json)
end
