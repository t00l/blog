json.array!(@posts) do |post|
  json.extract! post, :id, :titulo, :content
  json.url post_url(post, format: :json)
end
