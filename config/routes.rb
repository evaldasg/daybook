Daybook::Application.routes.draw do
  root "users#index"
  resources :users

  get "signup" => "users#new"

end
