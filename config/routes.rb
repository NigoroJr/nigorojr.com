Nigorojr::Application.routes.draw do
  get "about" => "top#about"

  root "top#index"

  resources :articles do
    collection { get "search" }
  end

  resources :products do
    collection { get "search" }
  end

  get "gallery" => "photos#index"
end
