RockPaperScissors::Application.routes.draw do
  root to: 'players#new'

  resources :players
  resources :games do
    post :add_move
  end
end