Nigorojr::Application.routes.draw do
  get "about" => "top#about"

  root "top#index"

  resources :tips do
    collection { get "search" }
  end
end
