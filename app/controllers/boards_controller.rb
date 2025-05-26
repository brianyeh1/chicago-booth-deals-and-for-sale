class BoardsController < ApplicationController
  def index
    matching_items = Item.all

    @list_of_items = matching_items.order({ :updated_at => :desc })

    render({ :template => "items/index" })
  end

  def category
    @the_category = params.fetch("path_id")
    matching_items = Item.where({ :category => @the_category})

    @list_of_items = matching_items.order({ :updated_at => :desc })

    render({ :template => "items/category" })
  end

  def mylisting
    if current_user == nil
      redirect_to("/users/sign_in", { :alert => "Please sign in to see your listing"} )
    else
    seller_id = current_user.id
    matching_items = Item.where({ :seller_id => seller_id})

    @list_of_items = matching_items.order({ :updated_at => :desc })

    render({ :template => "items/mylisting" })
    end
  end

  def savelisting
    if current_user == nil
      redirect_to("/users/sign_in", { :alert => "Please sign in save a listing"} )
    else
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)
    save = Save.new
    save.user_id = current_user.id
    save.item_id = the_item.id
    save.save
    redirect_to("/item/#{the_item.id}", { :notice => "Listing added to 'My listing'"} )
    end
  end

  def viewsavedlisting
    if current_user == nil
      redirect_to("/users/sign_in", { :alert => "Please sign in to see your saved listing"} )
    else
    user_id = User.where({ :id => current_user.id}).at(0)
    @list_of_items = user_id.user.order({ :updated_at => :desc })

    render({ :template => "items/savedlisting" })
    end
  end

  def add
    render({ :template => "items/add" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_item = Item.where({ :id => the_id })

    @the_item = matching_item.at(0)
    matching_user = User.where({ :id => @the_item.seller_id })
    @the_seller = matching_user.at(0)

    render({ :template => "items/show" })
  end

  def create
    the_item = Item.new
    the_item.category = params.fetch("category")
    the_item.name = params.fetch("name")
    the_item.description = params.fetch("description")
    if params.fetch("picture_1", nil)
      the_item.picture_1 = params.fetch("picture_1")
    end
    if params.fetch("picture_2", nil)
    the_item.picture_2 =  params.fetch("picture_2")
    end
    if params.fetch("picture_3", nil)
    the_item.picture_3 = params.fetch("picture_3")
    end
    if params.fetch("picture_4", nil)
    the_item.picture_4 = params.fetch("picture_4")
    end
    if params.fetch("picture_5", nil)
    the_item.picture_5 = params.fetch("picture_5")
    end
    raw_price = params.fetch("price")
    cleaned_price = raw_price.delete("$")
    the_item.price = cleaned_price.to_f
    the_item.payment_method = params.fetch("payment_method")
    the_item.delivery_method = params.fetch("delivery_method")
    the_item.seller_id = current_user.id

    if the_item.valid?
      the_item.save
      redirect_to("/item/#{the_item.id}", { :notice => "Listing created successfully." })
    else
      redirect_to("/new_listing", { :alert => the_item.errors.full_messages.to_sentence })
    end
  end

def current
    the_id = params.fetch("path_id")
    @the_item = Item.where({ :id => the_id }).at(0)
    render({ :template => "items/current" })
end

def update
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.category = params.fetch("category")
    the_item.name = params.fetch("name")
    the_item.description = params.fetch("description")
    if params.fetch("picture_1", nil)
      the_item.picture_1 = params.fetch("picture_1")
    end
    if params.fetch("picture_2", nil)
    the_item.picture_2 =  params.fetch("picture_2")
    end
    if params.fetch("picture_3", nil)
    the_item.picture_3 = params.fetch("picture_3")
    end
    if params.fetch("picture_4", nil)
    the_item.picture_4 = params.fetch("picture_4")
    end
    if params.fetch("picture_5", nil)
    the_item.picture_5 = params.fetch("picture_5")
    end
    raw_price = params.fetch("price")
    cleaned_price = raw_price.delete("$")
    the_item.price = cleaned_price.to_f
    the_item.payment_method = params.fetch("payment_method")
    the_item.delivery_method = params.fetch("delivery_method")
    the_item.seller_id = current_user.id

    if the_item.valid?
      the_item.save
      redirect_to("/item/#{the_item.id}", { :notice => "Listing updated successfully."} )
    else
      redirect_to("/item/#{the_item.id}", { :alert => the_item.errors.full_messages.to_sentence })
    end
  end

  def destroy
    if current_user == nil
      redirect_to("/users/sign_in", { :alert => "Please sign in to delete your listing"} )
    else
      the_id = params.fetch("path_id")
      the_item = Item.where({ :id => the_id }).at(0)

      if current_user.id == the_item.seller_id
        the_item.destroy

        redirect_to("/", { :notice => "Listing deleted successfully."} )
      else
        redirect_to("/item/#{the_item.id}", { :alert => "You cannot delete a listing that you're not the seller of"})
      end
    end
  end

  def search
     # params.fetch("q", {}) ensures we always pass a Hash to ransack
     @q = Item.ransack(params.fetch("q", {}))
     @items = @q.result
     render({ :template => "items/search_result" })
  end

end
