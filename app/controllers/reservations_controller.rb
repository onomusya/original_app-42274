class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    @sites = Site.all
  end
end
