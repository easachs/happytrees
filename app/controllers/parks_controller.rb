class ParksController < ApplicationController

  def index
    if params[:sort] == "treecount"
      @parks = Park.sort_by_treecount
    else
      @parks = Park.sort_by_new
    end
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

  def destroy
    Park.destroy(params[:id])
    redirect_to '/parks'
  end

  private
  def park_params
    params.permit(:name, :year, :affluent)
  end
end