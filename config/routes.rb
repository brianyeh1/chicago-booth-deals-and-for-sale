Rails.application.routes.draw do
  devise_for :users

#Listing pages
root to: "boards#index"
  
#Create new listing

get("/new_listing", { :controller => "boards", :action => "add"})
post("/create_listing", { :controller => "boards", :action => "create" })

#Edit and delete listing
get("/current_listing/:path_id", { :controller => "boards", :action => "current"})
post("/modify_listing/:path_id", { :controller => "boards", :action => "update" })
get("/delete_listing/:path_id", { :controller => "boards", :action => "destroy" })

#Individual listing pages

get("/item/:path_id", { :controller => "boards", :action => "show"})

end
