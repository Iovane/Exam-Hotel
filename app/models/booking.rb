# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_create :generate_booking_code
  validate :no_overlapping_bookings, :booking_in_present


  def calculate_booking_price
    (booking_end - booking_start).to_i * booking_price
  end

  def booking_period
    (booking_end - booking_start).to_i
  end

  private
  def generate_booking_code
    # Use a combination of attributes or any other logic to generate a unique booking code
    self.booking_code = "#{room.hotel.title[0..2]}#{room.number}-#{SecureRandom.hex(4).upcase}"
  end

  def no_overlapping_bookings
    if overlapping_bookings.any?
      errors.add(:base, "This room is already booked for the selected dates.")
    end
  end

  def overlapping_bookings
    Booking.where(room_id: room_id)
           .where.not(id: id) # Exclude the current booking if it's an update
           .where("(booking_start <= ? AND booking_end >= ?) OR (booking_start <= ? AND booking_end >= ?)",
                  booking_end, booking_end, booking_start, booking_start)
  end

  def booking_in_present
    if booking_start < Date.today || booking_start > booking_end || booking_end < Date.today
      errors.add(:booking, "dates aren't valid")
    elsif booking_start == booking_end
      errors.add( :base,"Please book at least one day")
    end

  end
end

