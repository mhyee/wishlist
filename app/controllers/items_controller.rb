class ItemsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user,  :only => [:edit, :update, :destroy]

  def new
    @title = "New Item"
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      @item.owner = current_user
      flash[:success] = "Item added to wantlist"
      redirect_to current_user
    else
      render "new"
    end
  end

  def edit
    @title = "Edit item"
  end

  def update
    if @item.update_attributes(params[:item])
      flash[:success] = "Item updated"
      redirect_to current_user
    else
      @title = "Edit item"
      render "edit"
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item destroyed"
    redirect_to current_user
  end

private

  def correct_user
    @item = Item.find(params[:id])
    redirect_to(root_path) unless current_user?(@item.owner)
  end

end
