# frozen_string_literal: true

class ParkTreesController < ApplicationController
  def index
    @park = Park.find(params[:park_id])
    @trees = if params[:sort] == 'alpha'
               @park.trees.alphabetical
             elsif params[:diam]
               @park.trees.diam(params[:diam])
             else
               @park.trees
             end
  end

  def new
    @park = Park.find(params[:park_id])
  end

  def create
    @park = Park.find(params[:park_id])
    @park.trees.create(tree_params)
    redirect_to "/parks/#{@park.id}/trees"
  end

  private

  def tree_params
    params.permit(:species, :diameter, :healthy)
  end
end
