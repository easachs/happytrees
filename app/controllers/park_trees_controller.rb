class ParkTreesController < ApplicationController

  def index
    @park = Park.find(params[:id])
    if params[:sort] == "alpha"
      @trees = @park.trees.alphabetical.show_healthy
    else
      @trees = @park.trees.show_healthy
    end
  end

  def new
    @park = Park.find(params[:id])
  end

  def create
    @park = Park.find(params[:id])
    @park.trees.create(tree_params)
    redirect_to "/parks/#{@park.id}/trees"
  end

  private
  def tree_params
    params.permit(:species, :diameter, :healthy)
  end

end