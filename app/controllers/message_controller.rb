class MessageController < ApplicationController
 
  def create
    if current_user == nil
      redirect_to("/users/sign_in", { :alert => "Please sign in message a seller"} )
    else
    @item_id = params.fetch("path_id")
    @matching_item = Item.where({ :id => @item_id }).at(0)
    matching_seller = User.where({ :id => @matching_item.seller_id })
    @the_seller = matching_seller.at(0)
    render({ :template => "message/create" })
    end
  end
  
  def sent
    the_message = Message.new
    the_message.item_id = params.fetch("path_id")
    the_message.seller_id = Item.where({ :id => the_message.item_id }).at(0).seller_id
    the_message.buyer_id = current_user.id
    the_message.buyer_message = params.fetch("message")

    if the_message.valid?
      the_message.save
      redirect_to("/view_message/#{the_message.item_id}", { :notice => "Message sent to seller." })
    else
      redirect_to("/create_message/#{the_message.item_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def reply
    the_message = Message.new
    the_message.item_id = params.fetch("path_id")
    the_message.buyer_id = params.fetch("buyer_id")
    the_message.seller_id = params.fetch("seller_id")
    if the_message.seller_id == current_user.id
      the_message.seller_message = params.fetch("message")
    else
      the_message.buyer_message = params.fetch("message")
    end
      
    if the_message.valid?
      the_message.save
      redirect_to("/view_message/#{the_message.item_id}", { :notice => "Message sent." })
    else
      redirect_to("/create_message/#{the_message.item_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def inbox
    if current_user == nil
      redirect_to("/users/sign_in", { :alert => "Please sign in to view your inbox"} )
    else
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

  def view
    if current_user == nil
        redirect_to("/users/sign_in", { :alert => "Please sign in to view your message"} )
    else
      item_id = params.fetch("path_id")
      @the_item = Item.where({ :id => item_id }).at(0)
      @the_messages = Message.where({ :item_id => item_id }).order({ :updated_at => :asc })
      render({ :template => "message/view" })
    end
  end

end
