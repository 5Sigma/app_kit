Rails.application.routes.draw do
  get 'reporting/show'

  mount AppKit::Engine => "/"
  get 'reporting' => 'reporting#show', :as => :reporting
end
