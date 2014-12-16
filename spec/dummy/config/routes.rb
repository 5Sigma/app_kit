Rails.application.routes.draw do
  mount AppKit::Engine => "/"
  get 'report' => 'reporting#dashboard', :as => :reporting
end
