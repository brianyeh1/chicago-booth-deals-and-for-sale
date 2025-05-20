Rails.application.routes.draw do

#Listing pages
root to: "boards#index"
#get("/", { :controller => "boards", :action => "index"})
  
#Create new listing

get("/new_listing", { :controller => "boards", :action => "add"})
post("/create_listing", { :controller => "boards", :action => "create" })

end
