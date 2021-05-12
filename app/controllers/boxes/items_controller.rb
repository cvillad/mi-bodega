class Boxes::ItemsController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_box 
  before_action :set_item, except: [:new, :create]
  before_action :validate_use, only: [:update] 

  def new 
    @item = @box.items.build
  end

  def move
    boxes = Box.where.not(id: params[:box_id])
    @options = boxes.each.map{|box| [box.name, box.id]}
  end

  def update
    @target_box = current_tenant.boxes.find(params[:to_box])
    if @item.update(box_id: @target_box.id)
      cable_ready["accounts_channel:#{current_tenant.id}"].remove(
        selector: "#item-#{@item.id}"
      )
      cable_ready["accounts_channel:#{current_tenant.id}"].insert_adjacent_html(
        selector: "#box-#{@target_box.id}",
        position: "beforeend",
        html: render_to_string(partial: "item", locals: { item: @item, box: @target_box })
      )
      cable_ready.broadcast
      redirect_to @box, notice: "Item moved to box #{@target_box.name}"
    end
  end

  def create 
    @item = @box.items.build(item_params)
    if @item.save
      cable_ready["accounts_channel:#{current_tenant.id}"].insert_adjacent_html(
        selector: "#box-#{@box.id}",
        position: "beforeend",
        html: render_to_string(partial: "item", locals: { item: @item, box: @box })
      )
      cable_ready.broadcast
      redirect_to @box, notice: "Item created succesfully"
    else
      redirect_to @box, alert: "Failed to create item"
    end
  end

  def destroy 
    @item.destroy 
    cable_ready["accounts_channel:#{current_tenant.id}"].remove(
      selector: "#item-#{@item.id}"
    )
    cable_ready.broadcast
    flash[:notice] = "Item deleted successfully"
    redirect_to @box
  end

  private 
  def set_box 
    @box = Box.find(params[:box_id])
  end

  def set_item 
    @item = @box.items.find(params[:id])
  rescue
    redirect_to @box, alert: "Selected item doesn't exist in this box"
  end

  def item_params 
    params.require(:item).permit(:description, :image)
  end

  def validate_use
    redirect_to @box, alert: "There is another member using the item at this time" if !@item.using_by.nil?
  end

end