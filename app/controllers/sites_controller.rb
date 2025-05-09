class SitesController < ApplicationController
  def index
    @reservations = Reservation.all
  end
end
