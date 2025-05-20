Rails.application.routes.draw do
  devise_for :users

#Listing pages
root to: "boards#index"
  
#Create new listing

get("/new_listing", { :controller => "boards", :action => "add"})
post("/create_listing", { :controller => "boards", :action => "create" })

#Individual listing pages

get("/item/:path_id", { :controller => "boards", :action => "show"})

end
