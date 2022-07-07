class ParksController < ApplicationController

  def index
    @parks = Park.order(created_at: :desc)
  end

  def show
    @park = Park.find(params[:id])
  end

end