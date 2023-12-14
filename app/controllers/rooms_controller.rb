class RoomsController < ApplicationController
  before_action :find_hotel, only: [:new, :create, :edit]
  before_action :authorize_admin
  before_action :find_room, only: [:edit, :update, :destroy]
  def new
    @room = @hotel.rooms.build
  end

  def create
    @room = @hotel.rooms.build(room_params)
    if @room.save
      redirect_to @hotel, notice: "Room was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = @hotel.rooms.find(params[:id])
  end

  def update
    if @room.update(room_params)
      redirect_to @room.hotel, notice: "Room info updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to @room.hotel, notice: "Room was deleted"
  end

  private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id])
    unless @hotel
      redirect_to root_path, alert: "Hotel not found"
    end
  end

  def find_room
    @room = Hotel.find(params[:hotel_id]).rooms.find(params[:id])
    redirect_to @hotel, alert: "Room not found" unless @room
  end

  def room_params
    params.require(:room).permit( :price, :description, :number).merge(hotel_id: params[:hotel_id])
  end

  def authorize_admin
    redirect_to root_path, alert: 'You do not have permission to perform this action.' unless current_user.admin?
  end
end
