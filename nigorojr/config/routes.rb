Nigorojr::Application.routes.draw do
  get "about" => "top#about"

  root "top#index"
end
