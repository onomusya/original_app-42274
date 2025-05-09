class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
    @sites = Site.all
  end

  def new
    @reservation = Reservation.new(start_date: params[:date])
    @sites = Site.all
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      @sites = Site.all
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:site_id, :start_date, :end_date)
  end
  
end
