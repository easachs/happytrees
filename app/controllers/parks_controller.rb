class ParksController < ApplicationController

  def index
    @parks = Park.sort_by_new
  end

  def show
    @park = Park.find(params[:id])
  end

end