class ParkTreesController < ApplicationController

  def index
    @park = Park.find(params[:id])
    @trees = @park.trees
  end

end