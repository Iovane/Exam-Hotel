class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :hotel_id, message: "Room with that number already exists" },
            numericality: { only_integer: true, greater_than: 0 }

end