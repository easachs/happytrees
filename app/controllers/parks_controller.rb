# frozen_string_literal: true

class ParksController < ApplicationController
  def index
    @parks = if params[:sort] == 'treecount'
               Park.sort_by_treecount
             elsif params[:exact_search]
               Park.exact_search(params[:exact_search])
             elsif params[:partial_search]
               Park.partial_search(params[:partial_search])
             else
               Park.sort_by_new
             end
  end

  def show
    @park = Park.find(params[:id])
  end

  def new; end

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
