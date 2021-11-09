Rails.application.routes.draw do
  resources :tracks
  resources :playlists
  resources :users
  get "/auth/spotify/callback", to: "users#find_or_create_spotify_user"
  root to: "sessions#login_with_spotify"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
