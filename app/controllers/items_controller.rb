class ItemsController < ApplicationController
  before_filter :authenticate,  :only => [:new, :create, :edit, :update, :destroy]

  def new
    @title = "New Item"
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    @item.owner = current_user
    if @item.save
      flash[:success] = "Item added to wantlist"
      redirect_to current_user
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
