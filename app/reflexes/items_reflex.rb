class ItemsReflex < ApplicationReflex 
  def use
    item = Item.find(element.dataset[:id])
    if item.using_by.nil?
      item.update(using_by_id: element.dataset[:current_member])
    else
      flash.now[:alert] = "This item is being used by another user"
    end
  end

  def return
    item = Item.find(element.dataset[:id])
    item.update(using_by_id: nil)
  end
end