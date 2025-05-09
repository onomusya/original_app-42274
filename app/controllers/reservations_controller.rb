class ReservationsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @reservations = Reservation.all
    @sites = Site.all
  end
end
