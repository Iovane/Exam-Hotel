# frozen_string_literal: true

class BookingsController < ApplicationController

  before_action :set_room, only: [:new, :create]

  def index
    if current_user.admin?
      @bookings = Booking.all
    else
      @bookings = current_user.bookings
    end
  end
  def new
    @booking = @room.bookings.new
  end


  def create
    @room = Room.find(params[:room_id])
    @booking = current_user.bookings.build(booking_params)
    @booking.room = @room
    @booking.booking_price = @room.price

    if @booking.save
      redirect_to @room.hotel, notice: 'Booking was successfully created.'
    else
      flash.now[:messages] = @booking.errors.full_messages[0]
      render :new, status: :unprocessable_entity
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:booking_code, :booking_start, :booking_end, :room_id, :booking_price)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
