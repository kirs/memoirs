Memoirs::Application.routes.draw do

  resources :ruby_gems, only: :index do
    resources :versions, only: [:index, :show]
  end

end
