class Boxes::ItemsController < ApplicationController
  before_action :set_box 
  before_action :set_item, except: [:new, :create]

  def new 
    @item = @box.items.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def move
    boxes = Box.select(:id, :name).where.not(id: params[:box_id])
    @options = boxes.each.map{|box| [box.name, box.id]}
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def update
    @target_box = current_tenant.boxes.find(params[:to_box])
    if @item.update(box_id: @target_box.id)
      redirect_to @box, notice: "Item moved to box #{@target_box.name}"
    end
  end

  def create 
    @item = @box.items.build(item_params)
    respond_to do |format|
      if @item.save
        format.html{redirect_to @box, notice: "Item created succesfully"}
        format.js
      else
        format.html{redirect_to @box, alert: "Failed to create item"}
        format.js
      end
    end
  end

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

  def item_params 
    params.require(:item).permit(:description, :image)
  end

end