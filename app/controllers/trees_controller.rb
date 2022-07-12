class TreesController < ApplicationController

  def index
    if params[:exact_search]
      @trees = Tree.exact_search(params[:exact_search])
    elsif params[:partial_search]
      @trees = Tree.partial_search(params[:partial_search])
    else
      @trees = Tree.show_healthy
    end
  end

  def show
    @tree = Tree.find(params[:id])
  end

  def edit
    @tree = Tree.find(params[:id])
  end

  def update
    tree = Tree.find(params[:id])
    tree.update(tree_params)
    tree.save
    redirect_to "/trees/#{tree.id}"
  end

  def destroy
    Tree.destroy(params[:id])
    redirect_to '/trees'
  end

  private
  def tree_params
    params.permit(:species, :diameter, :healthy)
  end
end