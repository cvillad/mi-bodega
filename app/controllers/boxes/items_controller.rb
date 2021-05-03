class Boxes::ItemsController < ApplicationController
  before_action :set_box 
  before_action :set_item, only: :destroy

  def destroy 
    @item.destroy 
    flash[:notice] = "Item deleted successfully"
    redirect_to @box
  end

  private 
  def set_box 
    @box = Box.find(params[:box_id])
  end

  def set_item 
    @item = @box.items.find(params[:id])
  end

end