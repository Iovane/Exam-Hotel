json.extract! hotel, :id, :title, :address, :user_id, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
