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
    @user_id = current_user.id
    seller_updates = Message.where({ :seller_id => @user_id }).group(:item_id).maximum(:updated_at)
    @seller_unique_messages = seller_updates.map   do |item, ts|
        Message.where({ :seller_id => @user_id, :item_id => item, :updated_at => ts }).at(0)
      end

    buyer_updates = Message.where({ :buyer_id => @user_id }).group(:item_id).maximum(:updated_at)
    @buyer_unique_messages = buyer_updates.map   do |item, ts|
      Message.where({ :buyer_id => @user_id, :item_id => item, :updated_at => ts }).at(0)
    end

    render({ :template => "message/inbox" })
  end

end
