class ParksController < ApplicationController

  def index
    @parks = Park.sort_by_new
  end

  def show
    @park = Park.find(params[:id])
  end

  def new
  end

  def create
    Park.create(park_params)
    redirect_to '/parks'
  end

  def edit
    @park = Park.find(params[:id])
  end

  def update
    park = Park.find(params[:id])
    park.update(park_params)
    park.save
    redirect_to "/parks/#{park.id}"
  end

  private
  def park_params
    params.permit(:name, :year, :affluent)
  end
end