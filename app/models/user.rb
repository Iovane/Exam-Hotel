class User < ApplicationRecord
  has_many :bookings, dependent: :destroy

  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
