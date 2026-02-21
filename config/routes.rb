Rails.application.routes.draw do
  root "home#index"
  get "/collection", to: "collections#show"
end
