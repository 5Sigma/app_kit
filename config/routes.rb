AppKit::Engine.routes.draw do
  get "/" => "dashboard#show", :as => :dashboard
end
