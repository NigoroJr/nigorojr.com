Nigorojr::Application.routes.draw do
  get "about" => "top#about"
  get "gallery" => "photos#index"
  get "admin" => "admin#index"
  # /users/new shows a form to create new user
  get "/users/new" => "users#new"
  # /users/:screen shows articles of that user (for now)
  get "/users/:username" => "users#show"

  get "/skk" => "skkdict_entries#index"

  root "top#index"

  resources :articles do
    collection { get "search" }
  end

  resources :products do
    collection { get "search" }
  end

  resources :photos

  resources :users, except: [:index]

  resource :session, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

  resources :skkdict_entries, except: [:show], path: "skk" do
    collection { get "search" }
  end
end
