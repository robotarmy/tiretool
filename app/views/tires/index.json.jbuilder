json.array!(@tires) do |tire|
  json.extract! tire, :id, :width, :profile, :rim_size, :speed_rating
  json.url tire_url(tire, format: :json)
end
