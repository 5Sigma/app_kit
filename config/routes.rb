AppKit::Engine.routes.draw do
  devise_for :users, class_name: "AppKit::User", module: :devise
  root to: "dashboard#show"
  get "/" => "dashboard#show", :as => :dashboard
end
