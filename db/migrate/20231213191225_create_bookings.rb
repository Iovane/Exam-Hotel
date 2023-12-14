class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :booking_code
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.date :booking_start
      t.date :booking_end

      t.timestamps
    end
  end
end
