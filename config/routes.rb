Rails.application.routes.draw do
  devise_for :users

#Listing pages
root to: "boards#index"
get("/my_listing", { :controller => "boards", :action => "mylisting"})
get("/save_listing/:path_id", { :controller => "boards", :action => "savelisting"})
get("/saved_listing", { :controller => "boards", :action => "viewsavedlisting"})
get("/search_result", { :controller => "boards", :action => "search" })
get("/category/:path_id", { :controller => "boards", :action => "category" })

#Create new listing

get("/new_listing", { :controller => "boards", :action => "add"})
post("/create_listing", { :controller => "boards", :action => "create" })

#Edit and delete listing
get("/current_listing/:path_id", { :controller => "boards", :action => "current"})
post("/modify_listing/:path_id", { :controller => "boards", :action => "update" })
get("/delete_listing/:path_id", { :controller => "boards", :action => "destroy" })

#Individual item pages
get("/item/:path_id", { :controller => "boards", :action => "show"})

#Messaging pages
get("/create_message/:path_id", { :controller => "message", :action => "create"})
post("/send_message/:path_id", { :controller => "message", :action => "sent"})
get("/inbox", { :controller => "message", :action => "inbox"})
get("/view_message/:path_id", { :controller => "message", :action => "view"})
post("/reply/:path_id", { :controller => "message", :action => "reply"})

end
