class ItemsController < ApplicationController
  before_filter :authenticate
  before_filter :item_owner,  :only => [:edit, :update, :destroy]

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

  def claim
    @item = Item.find(params[:id])
    if !@item.claimed? && @item.owner != current_user
      @item.claimer = current_user
      flash[:success] = "Item added to your claimlist"
    elsif @item.claimed?
      flash[:error] = "Item has already been claimed!"
    end
    redirect_to @item.owner
  end

  def unclaim
    @item = Item.find(params[:id])
    if @item.claimed? && @item.claimer == current_user
      @item.claimer = nil
      flash[:success] = "Item removed from your claimlist"
    end
    redirect_to current_user
  end

private

  def item_owner
    @item = Item.find(params[:id])
    redirect_to(root_path) unless current_user?(@item.owner)
  end

end
