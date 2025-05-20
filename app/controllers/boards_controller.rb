class BoardsController < ApplicationController
  def index
    matching_items = Item.all

    @list_of_items = matching_items.order({ :created_at => :desc })

    render({ :template => "items/index" })
  end

  def add
    render({ :template => "items/add" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_item = Item.where({ :id => the_id })

    @the_item = matching_item.at(0)

    render({ :template => "items/show" })
  end

  def create
    the_item = Item.new
    the_item.category = params.fetch("category")
    the_item.name = params.fetch("name")
    the_item.description = params.fetch("description")
    the_item.picture_1 = params.fetch("picture_1")
    the_item.picture_2 =  params.fetch("picture_2")
    the_item.picture_3 = params.fetch("picture_3")
    the_item.picture_4 = params.fetch("picture_4")
    the_item.picture_5 = params.fetch("picture_5")
    the_item.price = params.fetch("price")
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

end
