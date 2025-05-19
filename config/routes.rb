Rails.application.routes.draw do

  get("/", { :controller => "boards", :action => "index"})
  
end
