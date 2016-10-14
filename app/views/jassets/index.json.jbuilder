json.array!(@jassets) do |jasset|
  json.extract! jasset, :id, :title, :description, :link_name, :link_uri, :sort, :image
  json.url jasset_url(jasset, format: :json)
end
