class MessageController < ApplicationController
 
  def create
    @item_id = params.fetch("path_id")
    @matching_item = Item.where({ :id => @item_id }).at(0)

    render({ :template => "message/create" })
  end
  
  def sent
    the_message = Message.new
    the_message.item_id = params.fetch("path_id")
    the_message.seller_id = Item.where({ :id => the_message.item_id }).at(0).seller_id
    the_message.buyer_id = current_user.id
    the_message.message = params.fetch("message")

    if the_message.valid?
      the_message.save
      redirect_to("/view_message/#{the_message.item_id}", { :notice => "Message sent to seller." })
    else
      redirect_to("/create_message/#{the_message.item_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def inbox

    render({ :template => "message/inbox" })
  end

end
