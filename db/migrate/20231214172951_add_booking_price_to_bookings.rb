class AddBookingPriceToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booking_price, :integer
  end
end
