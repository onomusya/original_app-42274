class SitesController < ApplicationController


  def index
    @sites = Site.all
    @reservations = Reservation.all
  end
end
