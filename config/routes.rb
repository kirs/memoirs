Memoirs::Application.routes.draw do

  resources :ruby_gems, only: :show do
    resources :versions, only: [:index, :show]
  end

end
