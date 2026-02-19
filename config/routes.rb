Rails.application.routes.draw do
  get "home/index"
  get "/collection", to: "collections#show"
  root "home#index"
end
