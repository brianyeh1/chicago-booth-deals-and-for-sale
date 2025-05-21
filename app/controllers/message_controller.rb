class MessageController < ApplicationController
 
  def create
    @item_id = params.fetch("path_id")
    @matching_item = Item.where({ :id => @item_id }).at(0)

    render({ :template => "message/create" })
  end
  

end
