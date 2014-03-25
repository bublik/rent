json.array!(@renters) do |renter|
  json.extract! renter, :id, :phone, :email, :guard_time, :town, :rooms, :amount, :сheck_in, :description
  json.url renter_url(renter, format: :json)
end
